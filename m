Return-Path: <netfilter-devel+bounces-7102-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA76AB4AE6
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 May 2025 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816C0466819
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 May 2025 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866801E1DFE;
	Tue, 13 May 2025 05:20:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006C22EE5
	for <netfilter-devel@vger.kernel.org>; Tue, 13 May 2025 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113624; cv=none; b=hU7osKorIuC780E6qmHQIZZFbaAHPGstiLbhhxUwj6SnIyD9bcpNzmnnspTF7/UWn4po6sU+acqKJSGeJZ245HoHbh8B4gW8mStuAhVcs8lSX6fsi80JuNEbMGjHNOmHZjt3rrOWbjq3qpBqoWftcojj/EQXPdzJL2YhEh95WNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113624; c=relaxed/simple;
	bh=vlKLquLczj0LDh+qUZtoKkcAJNV1UKoEcDN9Jjype9I=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=o0sq+xU6bJsip7afv4LTNew7cmouIPbDu8VnCsjKk2+s4JCULTM/d9g5MYPvobYY09iklTGd4gVmkEZPBgl4frEw86E+phn59lo55Hbqt/u74HN+iddh8qjoGPIq612PJbcwIJezWacmnh9L2pmsMRZvCx4jev0FLjpnc7hDHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.64.224])
	by mtasvr (Coremail) with SMTP id _____wDXNziF1iJoACBDAQ--.2438S3;
	Tue, 13 May 2025 13:20:05 +0800 (CST)
Received: from 22321077$zju.edu.cn ( [10.190.64.224] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 13 May 2025 13:20:05 +0800
 (GMT+08:00)
Date: Tue, 13 May 2025 13:20:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5ZGo5oG66Iiq?= <22321077@zju.edu.cn>
To: netfilter-devel@vger.kernel.org
Subject: Re: Re: Fix resource leak in iptables/xtables-restore.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241206(f7804f05) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <aCHMICSGU2LT7SS-@orbyte.nwl.cc>
References: <87aa5c8.77e3.196c354f80c.Coremail.22321077@zju.edu.cn>
 <aCHMICSGU2LT7SS-@orbyte.nwl.cc>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <63b7ba31.88a5.196c815f8b5.Coremail.22321077@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zS_KCgC3qTyF1iJoEKAYAA--.1849W
X-CM-SenderInfo: qsstjiaqxxq6lmxovvfxof0/1tbiBgEFA2giAhQeqwADsr
X-CM-DELIVERINFO: =?B?BbQfsQXKKxbFmtjJiESix3B1w3st9zawssEjFy5Mij1sbnSF+UqcrL28bbYbthgFzE
	NeY7Kqmwqq98oKYO6QOeRPBG4cy3ZTrsWl2nlB3Q8jg3AqdJpQFaePFSVixlH5oFx8vS14
	3JUHd09OBlQ/gBxMFHeDUVmLASgCeHCTDkcgp40t7Ke058gCoiBUUDasSV+9/w==
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW8ZF1ftF1Duw4UAFW5urX_yoW5JrWkpF
	sxAa47trW3JryDJ3Wxtw17KFyayFsYqr1kGr1jyw1xXws8urykGw4fGrWfWas7ArW8Za4F
	vr4Ikr10vFWkZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUJKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24l
	FcxC0VAYjxAxZF0Ex2IqxwACY4xI67k04243AVC20s0264xvF2IEb7IF0Fy264kE64k0F2
	IE4x8a64kEw2IEx4CE17CEb7AF67AKxVWUJVWUXwACY4xI67k04243AVC20s026xCjnVAK
	z4kI6I8E67AF67kF1VAFwI0_Jr0_Jryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0V
	AYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU0lAp5UUUUU==

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQoKCj4gRnJvbTogIlBoaWwgU3V0dGVyIiA8
cGhpbEBud2wuY2M+Cgo+IFNlbnQ6IE1vbmRheSwgTWF5IDEyLCAyMDI1IDE4OjIzOjI4Cj4gVG86
IOWRqOaBuuiIqiA8MjIzMjEwNzdAemp1LmVkdS5jbj4KPiBDYzogbmV0ZmlsdGVyLWRldmVsQHZn
ZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBGaXggcmVzb3VyY2UgbGVhayBpbiBpcHRhYmxl
cy94dGFibGVzLXJlc3RvcmUuY2MKPiAKPiBIaSwKPiAKPiBPbiBNb24sIE1heSAxMiwgMjAyNSBh
dCAwMzoxMDo0N1BNICswODAwLCDlkajmgbroiKogd3JvdGU6Cj4gPiBUaGUgZnVuY3Rpb24geHRh
Ymxlc19yZXN0b3JlX21haW4gb3BlbnMgYSBmaWxlIHN0cmVhbSBwLmluIGJ1dCBmYWlscyB0byBj
bG9zZSBpdCBiZWZvcmUgcmV0dXJuaW5nLiBUaGlzIGxlYWRzIHRvIGEgcmVzb3VyY2UgbGVhayBh
cyB0aGUgZmlsZSBkZXNjcmlwdG9yIHJlbWFpbnMgb3Blbi4KPiA+IAo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBLYWloYW5nIFpob3UgPDIyMzIxMDc3QHpqdS5lZHUuY24+Cj4gPiAKPiA+IC0tLQo+
ID4gIGlwdGFibGVzL3h0YWJsZXMtcmVzdG9yZS5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4gPiAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2lwdGFibGVzL3h0YWJs
ZXMtcmVzdG9yZS5jIGIvaXB0YWJsZXMveHRhYmxlcy1yZXN0b3JlLmMKPiA+IAo+ID4gaW5kZXgg
ZTc4MDJiOWUuLmYwOWFiN2VlIDEwMDY0NAo+ID4gLS0tIGEvaXB0YWJsZXMveHRhYmxlcy1yZXN0
b3JlLmMKPiA+ICsrKyBiL2lwdGFibGVzL3h0YWJsZXMtcmVzdG9yZS5jCj4gPiBAQCAtMzgxLDYg
KzM4MSw3IEBAIHh0YWJsZXNfcmVzdG9yZV9tYWluKGludCBmYW1pbHksIGNvbnN0IGNoYXIgKnBy
b2duYW1lLCBpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ID4gICAgICAgICAgICAgICAgIGJyZWFr
Owo+ID4gICAgICAgICBkZWZhdWx0Ogo+ID4gICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJy
LCAiVW5rbm93biBmYW1pbHkgJWRcbiIsIGZhbWlseSk7Cj4gPiArICAgICAgICAgICAgICAgZmNs
b3NlKHAuaW4pOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAxOwo+ID4gICAgICAgICB9Cj4g
Cj4gU2luY2UgdGhpcyBpcyBub3QgdGhlIG9ubHkgZXJyb3IgcGF0aCB3aGljaCBsZWF2ZXMgcC5p
biBvcGVuIChlaWdodAo+IGxpbmVzIGJlbG93IGlzIHRoZSBuZXh0IG9uZSBmb3IgaW5zdGFuY2Up
LCB3aHkgZml4IHRoaXMgb25lIGluCj4gcGFydGljdWxhciBhbmQgbGVhdmUgdGhlIG90aGVyIG9u
ZXMgaW4gcGxhY2U/Cj4gCj4gQ2hlZXJzLCBQaGlsCgpBdCBmaXJzdCwgSSB0aG91Z2h0IHRoYXQg
bm90IGNsb3NpbmcgdGhlIGZpbGUgaGFuZGxlIGJlZm9yZSB0aGUgcmV0dXJuIHdhcyBtb3JlIHNl
cmlvdXMsIGFuZCB0aGF0IHdoZW4gZXhpdCB0ZXJtaW5hdGVzIHRoZSBwcm9ncmFtLCB0aGUgc3lz
dGVtIG1pZ2h0IGF1dG9tYXRpY2FsbHkgcmVjbGFpbSByZXNvdXJjZXMuIEJ1dCBpdCdzIG9idmlv
dXMgdGhhdCB0aGlzIHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcuIEJvdGggYXJlIGJhZCBwcm9ncmFt
bWluZyBoYWJpdHMgYW5kIG1heSBsZWFkIHRvIHByb2JsZW1zIGluIHJlc291cmNlIG1hbmFnZW1l
bnQgYW5kIHByb2dyYW0gc3RhYmlsaXR5LiBJJ3ZlIHJldmlzZWQgdGhlIHBhdGNoLlRoYW5rIHlv
dS4KCgoKU2lnbmVkLW9mZi1ieTogS2FpaGFuZyBaaG91IDwyMjMyMTA3N0B6anUuZWR1LmNuPgoK
Ci0tLQoKIGlwdGFibGVzL3h0YWJsZXMtcmVzdG9yZS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2lwdGFibGVzL3h0YWJsZXMtcmVzdG9yZS5j
IGIvaXB0YWJsZXMveHRhYmxlcy1yZXN0b3JlLmMKCgppbmRleCBlNzgwMmI5ZS4uNjJlZTY4ZmMg
MTAwNjQ0CgotLS0gYS9pcHRhYmxlcy94dGFibGVzLXJlc3RvcmUuYworKysgYi9pcHRhYmxlcy94
dGFibGVzLXJlc3RvcmUuYwpAQCAtMzgxLDYgKzM4MSw3IEBAIHh0YWJsZXNfcmVzdG9yZV9tYWlu
KGludCBmYW1pbHksIGNvbnN0IGNoYXIgKnByb2duYW1lLCBpbnQgYXJnYywgY2hhciAqYXJndltd
KQogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgZGVmYXVsdDoKICAgICAgICAgICAgICAg
IGZwcmludGYoc3RkZXJyLCAiVW5rbm93biBmYW1pbHkgJWRcbiIsIGZhbWlseSk7CisgICAgICAg
ICAgICAgICBmY2xvc2UocC5pbik7CiAgICAgICAgICAgICAgICByZXR1cm4gMTsKICAgICAgICB9
CgpAQCAtMzg5LDYgKzM5MCw3IEBAIHh0YWJsZXNfcmVzdG9yZV9tYWluKGludCBmYW1pbHksIGNv
bnN0IGNoYXIgKnByb2duYW1lLCBpbnQgYXJnYywgY2hhciAqYXJndltdKQoKCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgeHRhYmxlc19nbG9iYWxzLnByb2dyYW1fbmFtZSwKCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgeHRhYmxlc19nbG9iYWxzLnByb2dyYW1fdmVyc2lv
biwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlcnJvcihlcnJubykpOworICAg
ICAgICAgICAgICAgZmNsb3NlKHAuaW4pOwogICAgICAgICAgICAgICAgZXhpdChFWElUX0ZBSUxV
UkUpOwogICAgICAgIH0KICAgICAgICBoLm5vZmx1c2ggPSBub2ZsdXNoOwoKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQoyLjQzLjAKCgoKCgo=


