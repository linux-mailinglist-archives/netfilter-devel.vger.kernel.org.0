Return-Path: <netfilter-devel+bounces-717-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97419833210
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jan 2024 02:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656A91C20FF6
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jan 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAA650;
	Sat, 20 Jan 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C2NYFXEr"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED797F9
	for <netfilter-devel@vger.kernel.org>; Sat, 20 Jan 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705713081; cv=none; b=UPemTDbnCTgXh/LExHj1/exWrLuWfxJ1inY18d2Uqy3a34V8ZOX83ouXdqkGwRow9r9Lq404Olcsc9yhJyI95WJt7b1dN3qhu0jaDtTGnOXJWCcpv/WIsF6VNOVt8w6wDO+0hnxF8O64J8jCRLLevDoXjACUbOVRBZLG4pQ6gU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705713081; c=relaxed/simple;
	bh=WSUwDvS5r6dyu7oXvvuNwC7YerMGX7nhzNAdhQs6LF0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=guO/JCa/xtCRn67mbO9v9bp1XRvEYxccjyfGOPg7L2v0QzmkVtc+K6h37oWT1T/EhB3Dx8qM5orKrMpbVT5JGjTCkY8Bj5nTFKg0HBGT/ExQNmIHIUv7U++ddQ5zF0R1XQjozg4VfFPTcer0OuXiaS2VtRk0PsIrWDvqf1MKPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C2NYFXEr; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705713080; x=1737249080;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=WSUwDvS5r6dyu7oXvvuNwC7YerMGX7nhzNAdhQs6LF0=;
  b=C2NYFXErkKDOYv5MrpOPEIyy0MQvl73VKi40/ySQhxQ3t/VbDR6/cB9S
   IFLczxA6ZgKP/nB80x70jhfo8CUzG/s6MQMw0uXfEPffoeRqqvIWttzhx
   8vjp4mmDgPasJwxxnS7KfspBKIIhzMdTSxZNLJMxaRjMnRt96K7JaSwhp
   8=;
X-IronPort-AV: E=Sophos;i="6.05,206,1701129600"; 
   d="scan'208";a="628774752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 01:11:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 4F468804EB;
	Sat, 20 Jan 2024 01:11:17 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:3168]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.213:2525] with esmtp (Farcaster)
 id b2b8a94a-6557-4969-a1cf-c6c389aadfd8; Sat, 20 Jan 2024 01:11:16 +0000 (UTC)
X-Farcaster-Flow-ID: b2b8a94a-6557-4969-a1cf-c6c389aadfd8
Received: from EX19D004UWB003.ant.amazon.com (10.13.138.103) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 01:11:15 +0000
Received: from EX19D025UWB003.ant.amazon.com (10.13.138.94) by
 EX19D004UWB003.ant.amazon.com (10.13.138.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 01:11:15 +0000
Received: from EX19D025UWB003.ant.amazon.com ([fe80::e0bb:f04f:f227:6795]) by
 EX19D025UWB003.ant.amazon.com ([fe80::e0bb:f04f:f227:6795%6]) with mapi id
 15.02.1118.040; Sat, 20 Jan 2024 01:11:15 +0000
From: "Schaefer, Ryan" <ryanschf@amazon.com>
To: "fw@strlen.de" <fw@strlen.de>, "pablo@netfilter.org"
	<pablo@netfilter.org>, "kadlec@netfilter.org" <kadlec@netfilter.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "Thompson, Schuyler"
	<schuyler@amazon.com>, "coreteam@netfilter.org" <coreteam@netfilter.org>
Subject: PROBLEM: nf_conntrack tcp SYN reuse results in incorrect window
 scaling
Thread-Topic: PROBLEM: nf_conntrack tcp SYN reuse results in incorrect window
 scaling
Thread-Index: AQHaSz2QNIhU6FDvDUSPd7OrFgSKbg==
Date: Sat, 20 Jan 2024 01:11:15 +0000
Message-ID: <f01c0673e95f190074d0747b4ecfbc3f817e463e.camel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7E2FC444B2F044EBBF59035454945C7@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk

UFJPQkxFTTogbmZfY29ubnRyYWNrIHRjcCBTWU4gcmV1c2UgcmVzdWx0cyBpbiBpbmNvcnJlY3Qg
d2luZG93IHNjYWxpbmcNCg0KVGhlcmUgaXMgYSBidWcgaW4gbmV0ZmlsdGVyIGNvbm50cmFjayB0
Y3AgYmVoYXZpb3IuIENvbW1pdCBjN2FhYjRmMTcwMjENCigibmV0ZmlsdGVyOiBuZl9jb25udHJh
Y2tfdGNwOiByZS1pbml0IGZvciBzeW4gcGFja2V0cyBvbmx5IikgY2hhbmdlZA0KYmVoYXZpb3Ig
dGhhdCBicm9rZSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgd2hlbiB0aGVyZSBpcyBhIG5ldw0K
Y29ubmVjdGlvbiBhdHRlbXB0IG9uIGEgY29ubmVjdGlvbiBjdXJyZW50bHkgaW4gU1lOX1NFTlQg
c3RhdGUuIFRoZQ0KcmVzdWx0IGlzIGZ1dHVyZSBwYWNrZXRzIGFyZSBpbmNvcnJlY3RseSBjb25z
aWRlcmVkIG91dCBvZiB3aW5kb3cgYW5kDQpjYW4gYmUgZHJvcHBlZC4gVGhpcyBjYW4gYmUgcmVw
cm9kdWNlZCBieSBlbmFibGluZyBmaXJld2FsbCBydWxlcyBmb3INCnRjcCBhbmQgYXR0ZW1wdGlu
ZyB0byBjb25uZWN0IHRvIGEgc2VydmVyIHRoYXQgZG9lcyBub3QgcmVzcG9uZCB0bw0KU1lOcy4N
Cg0KS2V5d29yZHM6IGNvbm50cmFjaywgbmZfY29ubnRyYWNrX3RjcF9wcm90bw0KS2VybmVsIFZl
cnNpb246IDYuMTcyDQpLZXJuZWwgVmVyc2lvbiB3aXRob3V0IGJ1ZzogNS4xNQ0KDQpNYWNoaW5l
IDE6IC8vIGZvcmNlIGNvbm5lY3Rpb24gdHJhY2tpbmcgb2YgcG9ydCA5MDAwDQojIHN1ZG8gc3lz
Y3RsIG5ldC5uZXRmaWx0ZXIubmZfbG9nLjI9bmZfbG9nX2lwdjQNCiMgc3VkbyBzeXNjdGwgLXcg
bmV0Lm5ldGZpbHRlci5uZl9jb25udHJhY2tfbG9nX2ludmFsaWQ9Ng0KIyBzdWRvIGlwdGFibGVz
IC1BIE9VVFBVVCAtcCB0Y3AgLS1kcG9ydCA5MDAwIC1qIEFDQ0VQVA0KIyBzdWRvIGlwdGFibGVz
IC1BIElOUFVUIC1wIHRjcCAtbSB0Y3AgLS1zcG9ydCA5MDAwIC1tIHN0YXRlIC0tc3RhdGUNCkVT
VEFCTElTSEVEIC1qIEFDQ0VQVA0KIyBzdWRvIGlwdGFibGVzIC1QIElOUFVUIERST1A7IGlwdGFi
bGVzIC1QIE9VVFBVVCBEUk9QOw0KDQpNYWNoaW5lIDI6IC8vIGRpc2FibGUgcG9ydCA5MDAwIG9u
IHNlcnZlcg0KIyBzdWRvIGlwdGFibGVzIC1QIElOUFVUIERST1A7DQojIHNvY2F0IHNvY2F0IE9Q
RU46L2Rldi96ZXJvIFRDUDQtTElTVEVOOjkwMDAscmV1c2VhZGRyLGZvcmsNCg0KTWFjaGluZSAx
OiAvLyBwZXJmb3JtIGZpcnN0IGNvbm5lY3Rpb24gYXR0ZW1wdC4gY3RybCtjIGFmdGVyIHNvbWUN
CnNlY29uZHMNCiMgc29jYXQgT1BFTjovZGV2L3plcm8gVENQNDoxMC4wLjg1LjY1OjkwMDAsc291
cmNlcG9ydD01NTU2MA0KDQpNYWNoaW5lIDI6IC8vIGFsbG93IG5leHQgY29ubmVjdGlvbiBhdHRl
bXB0DQojIHN1ZG8gaXB0YWJsZXMgLUEgSU5QVVQgLXAgdGNwIC1tIHRjcCAtLWRwb3J0IDkwMDAg
LWogQUNDRVBUDQoNCk1hY2hpbmUgMTogcmVhdHRlbXB0IGNvbm5lY3Rpb24NCiMgc29jYXQgT1BF
TjovZGV2L3plcm8gVENQNDoxMC4wLjg1LjY1OjkwMDAsc291cmNlcG9ydD01NTU2MA0KIyBkbWVz
ZyB8IGdyZXAgOTAwMCB8IGdyZXAgIiBBQ0sgIiB8IHRhaWwgLW4xDQpbMTY2OTAuNjQ1MDY4XSBu
Zl9jdF9wcm90b182OiBTRVEgaXMgb3ZlciB1cHBlciBib3VuZCAyNjI0NTM3MDgzIChvdmVyDQp0
aGUgd2luZG93IG9mIHRoZSByZWNlaXZlcikgSU49ZXRoMCBPVVQ9DQpNQUM9MGU6NmM6MjA6NGQ6
NjE6MGE6MGU6ZmY6Njg6N2U6MWI6YTY6MDg6MDAgU1JDPTEwLjAuODUuNjUNCkRTVD0xMC4wLjgz
LjMwIExFTj01MiBUT1M9MHgwMCBQUkVDPTB4MDAgVFRMPTI1NSBJRD0xMTc4MSBERiBQUk9UTz1U
Q1ANClNQVD05MDAwIERQVD01NTU2MCBTRVE9MjY1MzIzMzMwMCBBQ0s9MjcyNjc3Mzk3NSBXSU5E
T1c9MjQ1NTUgUkVTPTB4MDANCkFDSyBVUkdQPTAgT1BUICgwMTAxMDgwQTQ3RjIxMzFEMkFCQzYy
QUEpDQoNClRoZSByZXBlYXQgc29jYXQgYXR0ZW1wdCB3aWxsIHJlc3VsdCBpbiByZS11c2luZyB0
aGUgc2FtZSA1LXR1cGxlIHdpdGgNCnRoZSBncmVhdGVyIFNFUSBudW1iZXIgYW5kIHRyaWdnZXIg
dGhlIGJ1Zy4gVGhpcyB3YXMgcmVwcm9kdWNlZCB3aXRoDQphZGRpdGlvbmFsIHByaW50cyBpbiB0
Y3BfaW5pdF9zZW5kZXIoKSBzaG93aW5nIHRoYXQgdGhlIHN0YXRlIHdhcw0KaW5jb3JyZWN0bHkg
cmVzZXQgZHVyaW5nIHRoZSBTWU4gcmV0cmFuc21pdC4NCg0KVGhlIGZvbGxvd2luZyBwYXRjaCBi
ZWxvdyBhZGRyZXNzZXMgdGhlIGlzc3VlLg0KDQpGcm9tIDkyZDk2OTAwNjZiZTEyNTBkOGFhYzMy
MTU5MzBjYjIyMjUxMGUxN2IgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBSeWFuIFNj
aGFlZmVyIDxyeWFuc2NoZkBhbWF6b24uY29tPg0KRGF0ZTogRnJpLCAxOSBKYW4gMjAyNCAxOTo1
MTo0NSArMDAwMA0KU3ViamVjdDogW1BBVENIXSBuZXRmaWx0ZXI6IGNvbm50cmFjazogY29ycmVj
dCB3aW5kb3cgc2NhbGluZyB3aXRoDQogcmV0cmFuc21pdHRlZCBTWU4NCg0KY29tbWl0IGM3YWFi
NGYxNzAyMSAoIm5ldGZpbHRlcjogbmZfY29ubnRyYWNrX3RjcDogcmUtaW5pdCBmb3Igc3luDQpw
YWNrZXRzDQpvbmx5IikgaW50cm9kdWNlcyBhIGJ1ZyB3aGVyZSBTWU5zIGluIE9SSUdJTkFMIGRp
cmVjdGlvbiBvbiByZXVzZWQgNS0NCnR1cGxlDQpyZXN1bHQgaW4gaW5jb3JyZWN0IHdpbmRvdyBz
Y2FsZSBuZWdvdGlhdGlvbi4gVGhpcyBjb21taXQgbWVyZ2VkIHRoZQ0KU1lODQpyZS1pbml0aWFs
aXphdGlvbiBhbmQgc2ltdWx0YW5lb3VzIG9wZW4gb3IgU1lOIHJldHJhbnNtaXRzIGNhc2VzLg0K
TWVyZ2luZw0KdGhpcyBibG9jayBhZGRlZCB0aGUgbG9naWMgaW4gdGNwX2luaXRfc2VuZGVyKCkg
dGhhdCBwZXJmb3JtZWQgd2luZG93DQpzY2FsZQ0KbmVnb3RpYXRpb24gdG8gdGhlIHJldHJhbnNt
aXR0ZWQgc3luIGNhc2UuIFByZXZpb3VzbHkuIHRoaXMgd291bGQgb25seQ0KcmVzdWx0IGluIHVw
ZGF0aW5nIHRoZSBzZW5kZXIncyBzY2FsZSBhbmQgZmxhZ3MuIEFmdGVyIHRoZSBtZXJnZSB0aGUN
CmFkZGl0aW9uYWwgbG9naWMgcmVzdWx0cyBpbiBpbXByb3Blcmx5IGNsZWFyaW5nIHRoZSBzY2Fs
ZSBpbiBPUklHSU5BTA0KZGlyZWN0aW9uIGJlZm9yZSBhbnkgcGFja2V0cyBpbiB0aGUgUkVQTFkg
ZGlyZWN0aW9uIGFyZSByZWNlaXZlZC4gVGhpcw0KcmVzdWx0cyBpbiBwYWNrZXRzIGluY29ycmVj
dGx5IGJlaW5nIG1hcmtlZCBpbnZhbGlkIGZvciBiZWluZw0Kb3V0LW9mLXdpbmRvdy4NCg0KVGhp
cyBjYW4gYmUgcmVwcm9kdWNlZCB3aXRoIHRoZSBmb2xsb3dpbmcgdHJhY2U6DQoNClBhY2tldCBT
ZXF1ZW5jZToNCj4gRmxhZ3MgW1NdLCBzZXEgMTY4Nzc2NTYwNCwgd2luIDYyNzI3LCBvcHRpb25z
IFsuLiB3c2NhbGUgN10sIGxlbmd0aCAwDQo+IEZsYWdzIFtTXSwgc2VxIDE5NDQ4MTcxOTYsIHdp
biA2MjcyNywgb3B0aW9ucyBbLi4gd3NjYWxlIDddLCBsZW5ndGggMA0KDQpJbiBvcmRlciB0byBm
aXggdGhlIGlzc3VlLCBvbmx5IGV2YWx1YXRlIHdpbmRvdyBuZWdvdGlhdGlvbiBmb3IgcGFja2V0
cw0KaW4gdGhlIFJFUExZIGRpcmVjdGlvbi4gVGhpcyB3YXMgdGVzdGVkIHdpdGggc2ltdWx0YW5l
b3VzIG9wZW4sIGZhc3QNCm9wZW4sIGFuZCB0aGUgYWJvdmUgcmVwcm9kdWN0aW9uLg0KDQpGaXhl
czogYzdhYWI0ZjE3MDIxICgibmV0ZmlsdGVyOiBuZl9jb25udHJhY2tfdGNwOiByZS1pbml0IGZv
ciBzeW4NCnBhY2tldHMgb25seSIpDQpTaWduZWQtb2ZmLWJ5OiBSeWFuIFNjaGFlZmVyIDxyeWFu
c2NoZkBhbWF6b24uY29tPg0KLS0tDQogbmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfcHJvdG9f
dGNwLmMgfCA2ICsrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90
b190Y3AuYw0KYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90b190Y3AuYw0KaW5kZXgg
ZTU3M2JlNWFmZGU3Li4zYzJjNzBhZTBiNjYgMTAwNjQ0DQotLS0gYS9uZXQvbmV0ZmlsdGVyL25m
X2Nvbm50cmFja19wcm90b190Y3AuYw0KKysrIGIvbmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tf
cHJvdG9fdGNwLmMNCkBAIC00NTcsNyArNDU3LDggQEAgc3RhdGljIHZvaWQgdGNwX2luaXRfc2Vu
ZGVyKHN0cnVjdCBpcF9jdF90Y3Bfc3RhdGUNCipzZW5kZXIsDQogCQkJICAgIGNvbnN0IHN0cnVj
dCBza19idWZmICpza2IsDQogCQkJICAgIHVuc2lnbmVkIGludCBkYXRhb2ZmLA0KIAkJCSAgICBj
b25zdCBzdHJ1Y3QgdGNwaGRyICp0Y3BoLA0KLQkJCSAgICB1MzIgZW5kLCB1MzIgd2luKQ0KKwkJ
CSAgICB1MzIgZW5kLCB1MzIgd2luLA0KKwkJCSAgICBlbnVtIGlwX2Nvbm50cmFja19kaXIgZGly
KQ0KIHsNCiAJLyogU1lOLUFDSyBpbiByZXBseSB0byBhIFNZTg0KIAkgKiBvciBTWU4gZnJvbSBy
ZXBseSBkaXJlY3Rpb24gaW4gc2ltdWx0YW5lb3VzIG9wZW4uDQpAQCAtNDcxLDcgKzQ3Miw4IEBA
IHN0YXRpYyB2b2lkIHRjcF9pbml0X3NlbmRlcihzdHJ1Y3QgaXBfY3RfdGNwX3N0YXRlDQoqc2Vu
ZGVyLA0KIAkgKiBCb3RoIHNpZGVzIG11c3Qgc2VuZCB0aGUgV2luZG93IFNjYWxlIG9wdGlvbg0K
IAkgKiB0byBlbmFibGUgd2luZG93IHNjYWxpbmcgaW4gZWl0aGVyIGRpcmVjdGlvbi4NCiAJICov
DQotCWlmICghKHNlbmRlci0+ZmxhZ3MgJiBJUF9DVF9UQ1BfRkxBR19XSU5ET1dfU0NBTEUgJiYN
CisJaWYgKGRpciA9PSBJUF9DVF9ESVJfUkVQTFkgJiYNCisJICAgICEoc2VuZGVyLT5mbGFncyAm
IElQX0NUX1RDUF9GTEFHX1dJTkRPV19TQ0FMRSAmJg0KIAkgICAgICByZWNlaXZlci0+ZmxhZ3Mg
JiBJUF9DVF9UQ1BfRkxBR19XSU5ET1dfU0NBTEUpKSB7DQogCQlzZW5kZXItPnRkX3NjYWxlID0g
MDsNCiAJCXJlY2VpdmVyLT50ZF9zY2FsZSA9IDA7DQotLSANCjIuNDAuMQ0KDQo=

