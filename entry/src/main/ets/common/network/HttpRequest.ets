import http from '@ohos.net.http';
import uri from '@ohos.uri';
import hilog from '@ohos.hilog';
import { Response } from './Response';
import CookieJar from './cookie/CookieJar';
import PersistentCookieJar from './cookie/PersistentCookieJar';
import EntryContext from '../utils/EntryContext';
import CookieUtils from './cookie/CookieUtils';

let TAG: string = "HttpRequest";
let BASE_URL: string = "https://baidu.com/";

let cookieJar: CookieJar = new PersistentCookieJar(EntryContext.getContext() as Context);

function parseUri(url: string): uri.URI {
  return new uri.URI(url);
}

async function requestSync<T>(path: string, method: http.RequestMethod, extraData?: Object): Promise<Response<T>> {
  return new Promise<Response<T>>((resolve, reject) => {
    let url = BASE_URL + path;
    let header = {};
    if (method === http.RequestMethod.POST) {
      header["Content-Type"] = "application/x-www-form-urlencoded";
      if (!extraData) {
        // POST 必须有请求体，否则会报 Parameter error
        extraData ={};
      }
    }
    let httpRequest = http.createHttp();
    hilog.info(0, TAG, `start request, path: ${path}, method: ${method}, extraData: ` + JSON.stringify(extraData));
    httpRequest.request(
      url,
      {
        method: method,
        expectDataType: http.HttpDataType.OBJECT,
        header: header,
        extraData: extraData
      },
      (err, data) => {
        let res = new Response<T>()
        if (!err && data.responseCode === 200) {
          Object.assign(res, data.result)
          hilog.info(0, TAG, `request success, path: ${path}, result: ${JSON.stringify(res)}`)
        } else {
          hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
          res.errorCode = data?.responseCode??-1
          res.errorMsg = err?.message??""
        }
        resolve(res);
      }
    )
  })
}

async function requestSyncCookie<T>(path: string, method: http.RequestMethod, extraData?: Object): Promise<Response<T>> {
  await cookieJar.init();
  return new Promise<Response<T>>((resolve, reject) => {
    let url = BASE_URL + path;
    let uri = parseUri(url);
    let header = {};
    let cookies = cookieJar.loadForRequest(uri);
    if (cookies.length > 0) {
      header["Cookie"] = CookieUtils.cookieHeader(cookies);
    }
    if (method === http.RequestMethod.POST) {
      header["Content-Type"] = "application/x-www-form-urlencoded";
      if (!extraData) {
        // POST 必须有请求体，否则会报 Parameter error
        extraData = {};
      }
    }
    let httpRequest = http.createHttp();
    hilog.info(0, TAG, `start request, path: ${path}, method: ${method}, extraData: ` + JSON.stringify(extraData));
    httpRequest.request(
      url,
      {
        method: method,
        expectDataType: http.HttpDataType.OBJECT,
        header: header,
        extraData: extraData
      },
      (err, data) => {
        let res = new Response<T>()
        if (!err && data.responseCode === 200) {
          cookieJar.saveFromResponse(uri, CookieUtils.parseHttpRequestCookies(data.cookies))
          if (typeof data.result === 'string') {
            Object.assign(res, JSON.parse(data.result));
          } else {
            Object.assign(res, data.result);
          }
          hilog.info(0, TAG, `request success, path: ${path}, result: ${JSON.stringify(res)}`)
        } else {
          hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
          res.errorCode = data?.responseCode??-1
          res.errorMsg = err?.message??""
        }
        resolve(res);
      }
    )
  })
}