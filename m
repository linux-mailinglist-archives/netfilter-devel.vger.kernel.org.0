Return-Path: <netfilter-devel+bounces-13490-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZBROJllGP2pXRAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13490-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 05:41:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4516D0F9D
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 05:41:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=temperror reason="query timed out" header.from=lzu.edu.cn (policy=temperror);
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13490-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13490-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548EB3041B84
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 03:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F60288C2D;
	Sat, 27 Jun 2026 03:38:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE111E32CF
	for <netfilter-devel@vger.kernel.org>; Sat, 27 Jun 2026 03:37:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782531480; cv=none; b=Qsaej3Rqw4CmQuOVcD3CWnyOV203XER+cEDGkvSxwx6F0uqKcDS64W5ffzGALvQ7wLj52hFAqidC5INo3pYQe0ULLGHCYqHoNiGeDRRkDSkWilQs7LMSbSgsZoYe/vCPmLtfAn40tKpopqEPQsCglhCcQ0dLb+l8IbsN66yLqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782531480; c=relaxed/simple;
	bh=bxlzSIlRYV7ooDt1juvg2EFNVeEgnigkpQ+oKb0pQKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Xwxq4f29kg6P4jfsgJQ7C1TvpL2JN5RNRmY0kbe+khmbHdJzs5g4PCmdehM5udKr+w4p3zFV7L7Pw44ffYKV7Hzu8qZkogb9GaTSaW8JLE0zIntMGIrTdQQIr0r+ZwQgSuCo1vRvffDQLUM8VDqn1J0G5A1cy7YmWnPqRTDwJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Received: from chzhengyang2023$lzu.edu.cn ( [172.20.238.44] ) by
 ajax-webmail-app1 (Coremail) ; Sat, 27 Jun 2026 11:37:38 +0800 (GMT+08:00)
Date: Sat, 27 Jun 2026 11:37:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5q2j6Ziz?= <chzhengyang2023@lzu.edu.cn>
To: "Pablo Neira Ayuso" <pablo@netfilter.org>
Cc: "Ren Wei" <n05ec@lzu.edu.cn>, netfilter-devel@vger.kernel.org,
	fw@strlen.de, phil@nwl.cc, alin.nastac@gmail.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn
Subject: Re: Re: [PATCH nf 1/1] netfilter: nf_conntrack_sip: guard against
 missing skb dst
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT5 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn lzu
In-Reply-To: <aj5j6YZG7f6fbtfn@chamomile>
References: <cover.1782349677.git.chzhengyang2023@lzu.edu.cn>
 <47e6e0bdba06326388cd7778403326ff78faf8f0.1782349677.git.chzhengyang2023@lzu.edu.cn>
 <aj5YwOF4Kc71OTdf@chamomile> <aj5j6YZG7f6fbtfn@chamomile>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <14f45d60.17b77.19f072786fe.Coremail.chzhengyang2023@lzu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ygmowAA3WsSCRT9qngK5AA--.12935W
X-CM-SenderInfo: xfk2xvpqj1t0rjsqjjo6o23hxhgxhubq/1tbiAQsLEGo+NlQLRAAB
	sp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13490-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:alin.nastac@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:alinnastac@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chzhengyang2023@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,strlen.de,nwl.cc,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chzhengyang2023@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,lzu.edu.cn:email,lzu.edu.cn:mid,lzu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A4516D0F9D

PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUGFibG8gTmVpcmEgQXl1c28i
IDxwYWJsb0BuZXRmaWx0ZXIub3JnPgo+IOWPkemAgeaXtumXtDoyMDI2LTA2LTI2IDE5OjM1OjA1
ICjmmJ/mnJ/kupQpCj4g5pS25Lu25Lq6OiAiUmVuIFdlaSIgPG4wNWVjQGx6dS5lZHUuY24+Cj4g
5oqE6YCBOiBuZXRmaWx0ZXItZGV2ZWxAdmdlci5rZXJuZWwub3JnLCBmd0BzdHJsZW4uZGUsIHBo
aWxAbndsLmNjLCBhbGluLm5hc3RhY0BnbWFpbC5jb20sIHl1YW50YW4wOThAZ21haWwuY29tLCB5
aWZhbnd1Y3NAZ21haWwuY29tLCB0b21hcHVmY2tnbWxAZ21haWwuY29tLCBiaXJkQGx6dS5lZHUu
Y24sIGNoemhlbmd5YW5nMjAyM0BsenUuZWR1LmNuCj4g5Li76aKYOiBSZTogW1BBVENIIG5mIDEv
MV0gbmV0ZmlsdGVyOiBuZl9jb25udHJhY2tfc2lwOiBndWFyZCBhZ2FpbnN0IG1pc3Npbmcgc2ti
IGRzdAo+IAo+IE9uIEZyaSwgSnVuIDI2LCAyMDI2IGF0IDEyOjQ3OjMxUE0gKzAyMDAsIFBhYmxv
IE5laXJhIEF5dXNvIHdyb3RlOgo+ID4gT24gRnJpLCBKdW4gMjYsIDIwMjYgYXQgMDI6NDk6MzdQ
TSArMDgwMCwgUmVuIFdlaSB3cm90ZToKPiA+ID4gRnJvbTogWmhlbmd5YW5nIENoZW4gPGNoemhl
bmd5YW5nMjAyM0BsenUuZWR1LmNuPgo+ID4gPiAKPiA+ID4gc2V0X2V4cGVjdGVkX3J0cF9ydGNw
KCkgZGVyZWZlcmVuY2VzIHNrYl9kc3Qoc2tiKS0+ZGV2IHdoZW4KPiA+ID4gc2lwX2V4dGVybmFs
X21lZGlhIGlzIGVuYWJsZWQuIFRoZSBTSVAgaGVscGVyIGNhbiBydW4gZnJvbSB0YyBpbmdyZXNz
Cj4gPiA+IGJlZm9yZSByb3V0aW5nIGhhcyBhdHRhY2hlZCBhIGRzdCB0byB0aGUgc2tiLCBzbyBz
a2JfZHN0KHNrYikgY2FuIGJlCj4gPiA+IE5VTEwgYW5kIHRoZSBoZWxwZXIgY3Jhc2hlcyB3aGls
ZSBwYXJzaW5nIFNEUCBtZWRpYSBleHBlY3RhdGlvbnMuCj4gPiAKPiA+IElmIFNJUCBoZWxwZXIg
Y2FuIHJ1biBmcm9tIHRjIGluZ3Jlc3MsIHRoZW4gdGhpcyBoYXMgbm90IGV2ZXIgd29ya2VkPwo+
ID4gRWxzZSB0YyBuZWVkcyB0byBiZSBmaXhlZCB0byBzZXQgYSByb3V0ZXIgdG8gc2tiIGJlZm9y
ZSBjYWxsaW5nIHRoZQo+ID4gaGVscGVyLgo+ID4gCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgZml4
IGJlbG9uZyBoZXJlLgo+Cj4gQWN0dWFsbHksIGl0IGlzIHRoZSBtb3N0IHNpbXBsZSB3YXkgdG8g
Zml4IGl0IGhlcmUsIGJ1dCBJIHBvc3RlZCBhCj4gZGlmZmVyZW50IGFwcHJvYWNoOgo+Cj4gaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGZpbHRlci1kZXZlbC9wYXRjaC8y
MDI2MDYyNjExMjQ0OS44NDgyODMtMS1wYWJsb0BuZXRmaWx0ZXIub3JnLwoKSSBjaGVja2VkIHlv
dXIgcGF0Y2ggYW5kIGl0IGFkZHJlc3NlcyB0aGUgaXNzdWUuCgpJZiB0aGF0IHBhdGNoIG1vdmVz
IGZvcndhcmQsIGNvdWxkIHRoZSBmb2xsb3dpbmcgdGFncyBwbGVhc2UgYmUKY29uc2lkZXJlZCBm
b3Igb3VyIHRlYW0/CgpSZXBvcnRlZC1ieTogWXVhbiBUYW4gPHl1YW50YW4wOThAZ21haWwuY29t
PgpSZXBvcnRlZC1ieTogWGluIExpdSA8YmlyZEBsenUuZWR1LmNuPgpSZXBvcnRlZC1ieTogWmhl
bmd5YW5nIENoZW4gPGNoemhlbmd5YW5nMjAyM0BsenUuZWR1LmNuPgoKPiA+ID4gSGFuZGxlIGEg
bWlzc2luZyBza2IgZHN0IGJ5IHNraXBwaW5nIHRoZSBzYW1lLWludGVyZmFjZSBleHRlcm5hbC1t
ZWRpYQo+ID4gPiBvcHRpbWl6YXRpb24uIFN0aWxsIHJlbGVhc2UgdGhlIHJvdXRlZCBtZWRpYSBk
c3Qgd2hlbiBvbmUgd2FzIG9idGFpbmVkLAo+ID4gPiBhbmQga2VlcCB0aGUgZXhpc3RpbmcgZXhw
ZWN0YXRpb24gc2V0dXAgcGF0aCB1bmNoYW5nZWQuCj4gPiA+IAo+ID4gPiBGaXhlczogYTM0MTlj
ZTMzNTZjICgibmV0ZmlsdGVyOiBuZl9jb25udHJhY2tfc2lwOiBhZGQgc2lwX2V4dGVybmFsX21l
ZGlhIGxvZ2ljIikKPgo+IEkgYW0gcG9pbnRpbmcgdG8gZGlmZmVyZW50IEZpeGVzOiB0YWcgZm9y
IHByYWN0aWNhbCByZWFzb25zLCB0bwo+IGhpZ2hsaWdodCB0aGlzIGlzIGEgZGVwZW5kZW5jaWVz
IGZvciB0aGUgdGMgYW5kIG92cyBzdWJzeXN0ZW1zLgo+IEl0IHNlZW1zIHNpcF9leHRlcm5hbF9t
ZWRpYSBjYW1lIF9hZnRlcl8gb3ZzIGJ1dCBhIGJpdCBiZWZvcmUgdGMKPiBhY3RfY3QsIHNvIGEz
NDE5Y2UzMzU2YyBpcyBub3QgcHJlY2lzZSBlaXRoZXIuCgpJIHVzZWQgYTM0MTljZTMzNTZjIGJl
Y2F1c2UgaXQgaW50cm9kdWNlZCB0aGUgc2lwX2V4dGVybmFsX21lZGlhCmJyYW5jaCBhbmQgdGhl
IHNrYl9kc3QoKSBkZXBlbmRlbmN5LiBBZnRlciBjaGVja2luZyB0aGUgYWZmZWN0ZWQKZW50cnkg
cG9pbnRzLCB0aGUgdGMvb3ZzIEZpeGVzIHRhZ3MgbG9vayBtb3JlIHN1aXRhYmxlIGZvciB0aGlz
CnN1Ym1pc3Npb24gYmVjYXVzZSB0aGUgY3Jhc2ggZGVwZW5kcyBvbiB0aG9zZSBoZWxwZXIgdXNl
cnMuCgo+Cj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gPiA+IFJlcG9ydGVkLWJ5
OiBZdWFuIFRhbiA8eXVhbnRhbjA5OEBnbWFpbC5jb20+Cj4gPiA+IFJlcG9ydGVkLWJ5OiBZaWZh
biBXdSA8eWlmYW53dWNzQGdtYWlsLmNvbT4KPiA+ID4gUmVwb3J0ZWQtYnk6IEp1ZWZlaSBQdSA8
dG9tYXB1ZmNrZ21sQGdtYWlsLmNvbT4KPiA+ID4gUmVwb3J0ZWQtYnk6IFhpbiBMaXUgPGJpcmRA
bHp1LmVkdS5jbj4KPiA+ID4gQXNzaXN0ZWQtYnk6IENvZGV4OmdwdC01LjQKPiA+ID4gU2lnbmVk
LW9mZi1ieTogWmhlbmd5YW5nIENoZW4gPGNoemhlbmd5YW5nMjAyM0BsenUuZWR1LmNuPgo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBSZW4gV2VpIDxuMDVlY0BsenUuZWR1LmNuPgo+ID4gPiAKPiA+ID4g
LS0tCj4gPiA+ICBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19zaXAuYyB8IDcgKysrKystLQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+
ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19zaXAuYyBi
L25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX3NpcC5jCj4gPiA+IGluZGV4IDVlYzNhNGE0YmJk
Ny4uMzAyZGM2MGM1MzgxIDEwMDY0NAo+ID4gPiAtLS0gYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50
cmFja19zaXAuYwo+ID4gPiArKysgYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19zaXAuYwo+
ID4gPiBAQCAtOTU2LDcgKzk1Niw4IEBAIHN0YXRpYyBpbnQgc2V0X2V4cGVjdGVkX3J0cF9ydGNw
KHN0cnVjdCBza19idWZmICpza2IsIHVuc2lnbmVkIGludCBwcm90b2ZmLAo+ID4gPiAgCQkJcmV0
dXJuIE5GX0FDQ0VQVDsKPiA+ID4gIAkJc2FkZHIgPSAmY3QtPnR1cGxlaGFzaFshZGlyXS50dXBs
ZS5zcmMudTM7Cj4gPiA+ICAJfSBlbHNlIGlmIChzaXBfZXh0ZXJuYWxfbWVkaWEpIHsKPiA+ID4g
LQkJc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHNrYl9kc3Qoc2tiKS0+ZGV2Owo+ID4gPiArCQlz
dHJ1Y3QgZHN0X2VudHJ5ICpza2Jkc3QgPSBza2JfZHN0KHNrYik7Cj4gPiA+ICsJCXN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYgPSBza2Jkc3QgPyBza2Jkc3QtPmRldiA6IE5VTEw7Cj4gPiA+ICAJCXN0
cnVjdCBkc3RfZW50cnkgKmRzdCA9IE5VTEw7Cj4gPiA+ICAJCXN0cnVjdCBmbG93aSBmbDsKPiA+
ID4gIAo+ID4gPiBAQCAtOTc3LDEyICs5NzgsMTQgQEAgc3RhdGljIGludCBzZXRfZXhwZWN0ZWRf
cnRwX3J0Y3Aoc3RydWN0IHNrX2J1ZmYgKnNrYiwgdW5zaWduZWQgaW50IHByb3RvZmYsCj4gPiA+
ICAJCS8qIERvbid0IHByZWRpY3QgYW55IGNvbm50cmFja3Mgd2hlbiBtZWRpYSBlbmRwb2ludCBp
cyByZWFjaGFibGUKPiA+ID4gIAkJICogdGhyb3VnaCB0aGUgc2FtZSBpbnRlcmZhY2UgYXMgdGhl
IHNpZ25hbGxpbmcgcGVlci4KPiA+ID4gIAkJICovCj4gPiA+IC0JCWlmIChkc3QpIHsKPiA+ID4g
KwkJaWYgKGRzdCAmJiBkZXYpIHsKPiA+ID4gIAkJCWJvb2wgZXh0ZXJuYWxfbWVkaWEgPSAoZHN0
LT5kZXYgPT0gZGV2KTsKPiA+ID4gIAo+ID4gPiAgCQkJZHN0X3JlbGVhc2UoZHN0KTsKPiA+ID4g
IAkJCWlmIChleHRlcm5hbF9tZWRpYSkKPiA+ID4gIAkJCQlyZXR1cm4gTkZfQUNDRVBUOwo+ID4g
PiArCQl9IGVsc2UgaWYgKGRzdCkgewo+ID4gPiArCQkJZHN0X3JlbGVhc2UoZHN0KTsKPiA+ID4g
IAkJfQo+ID4gPiAgCX0KPiA+ID4gIAo+ID4gPiAtLSAKPiA+ID4gMi40My4wCj4gPiA+IAoK

