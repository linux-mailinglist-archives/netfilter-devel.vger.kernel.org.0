Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3565E9DD
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Jan 2023 12:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjAEL1z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Jan 2023 06:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjAEL1g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:27:36 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2128.outbound.protection.outlook.com [40.107.6.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357885AC59
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Jan 2023 03:26:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwfQltBlY2FuT/o0Nymhz0PyYrLFrjJ9NnYMLs/rCSjwf1frV4x9BMDQLwUpgu3ayT6Jka6eNICv+tKY/zX/mOI8Ex23R2QrzQ2yEipc86XFYpmfdy7iBrx+0zH1EgeybPaKKcbNx3eQITEa/aQP/mR852PLtpGv5nU/A+zkskAhKPLmPCDOaJAr1HKfdFilsfQ19U+SpOYTHEdtEkwpdSADpzL4JpbT/EwviQ6PW06iruD5q9IDN+w39NE/1MAvib6p9O4zMzS0YLGi3TxYy+orjfdcA4eDqLBxdRIzLp3TjjJEQRdwZO0VBrYQQ3bXeaz1r8qdmzTsOlFjLAVqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKV01hkqQs/+6Ar7/7wAE3pxUK+xOgCJxOZAbym2D1w=;
 b=mCpQaFtxEEWHVFyJFoV13sBKGArFLHbdnx0bPkhXKJs0nib33wFOovjvQEWg1IwepOyO66DdAXf+sCqbcOwNdBbYDnDxDC4ZZAXJ7YGzN9tPVqs5JjlVCzpcneuPmUWg+67TwOlVmbobnWycYZ6DnmFJv0Rn788lhTMNB040IRzC/d+QhVw1Tj4kYR0e94TtQEnZL85bIFogfxbLVOXBf7brt3Hfuvx4zDFkSHYpT9V9VsN25YdfqtjStD6xAvF6+xlVu0wQqZFoIh6hEXCvKz01iC8pUnRSn81hFf2EKMrTYKQIVNJhSqqS7o99stQmN8ikyIDQUNG80aDtyXi7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKV01hkqQs/+6Ar7/7wAE3pxUK+xOgCJxOZAbym2D1w=;
 b=Bm0HD7xcGZoo6esWqSC/y2q420rXNgPIa7p6QgMBUrEqPm/K6I/xOj+donz9/VOyJsCo9ZwbSmFMUBK/ybqv0TALknBXuOdDJHw5hEcDYyQ66DiXcin0ysS5I2VaAulYmzY66Yg00OCK1x4bdW0ZvSU1/vSDtK9DJu4lnWAF6Lg=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PAXP189MB1928.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:277::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.7; Thu, 5 Jan
 2023 11:25:58 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::8f70:435b:ab64:9420]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::8f70:435b:ab64:9420%3]) with mapi id 15.20.5986.009; Thu, 5 Jan 2023
 11:25:58 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Florian Westphal <fw@strlen.de>
CC:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Long Xin <lxin@redhat.com>
Subject: RE: [RFC PATCH] netfilter: conntrack: simplify sctp state machine
Thread-Topic: [RFC PATCH] netfilter: conntrack: simplify sctp state machine
Thread-Index: AQHZIDEXupmbZt3GPUa7TaBi/McYSK6OM0UAgABMRqA=
Date:   Thu, 5 Jan 2023 11:25:58 +0000
Message-ID: <DBBP189MB14332BB11ED8648863C2E4F795FA9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230104113143.21769-1-sriram.yagnaraman@est.tech>
 <20230104124112.GC19686@breakpoint.cc>
In-Reply-To: <20230104124112.GC19686@breakpoint.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PAXP189MB1928:EE_
x-ms-office365-filtering-correlation-id: 27b8b4f0-34a6-4f9c-0161-08daef0f9e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8xTkB1WPRKfp+13vCaJRGUVoblFSNW6X4OD5YZIYY/2ey3uP2tSWzjqzGaohEt2KxSQxfTemSjkoanR6qFGdrv2BBOAXNMTpId5YNEhJr+JeuFfZbHu+H2lUK1toLKb1KP0NYmPwjirIJuuyEvlOehYc+JjPJnaYKUdd+xbc4G8Fiuz3BUzN4QtFL55oI1JEB+qGltlf8Mf0MZlFG3OkPyk6q5IKdtin0+kd6KJCyNvAQJxicvWFu22JCrN3eMPer4991GnwvMrUY7JMj3ZKr8ZYrmHDKwN0bd/SCOsB1cIA92Y8smZ0ZL7Bt1ZZeG5bSNOc3XkM9oLv0Z77oAhay1JHjbmzO3aM3EjhhE+dWXXDDwjVsL++wP43/b62bLGqZ7fHMPdUb1Zdi4ze0pOAhf68qS1SIFJ+sen9Ywm1B4t2dmgZsNuBIbdpA9+x70dXipbUwNwpD6AXoC3pacEAdE740fwhGD/4bgHn8zIgfJic4yEgX859ZzBmvBHMpZBfJC6HhhB83x8vfrobij1zt0GULivuS4X/w9zpUEb9r3EJHaZMMU79FE+jbSPb7prz0jWr3WloQM8gsLV4jZtScx4/1jcDJxRkNqTVkqxC9xRdlcnraouDCPe/RcBCvKBnUDqDapRZckCGCYSrj7UJ0dAZQFnwDNhqtzvIzcRq3Q8OgO8enyLr1aMl9JYgWI6H99KqTUDpUTiMc7HJ9PAjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(376002)(346002)(396003)(366004)(451199015)(55016003)(38070700005)(86362001)(6916009)(7696005)(71200400001)(966005)(316002)(54906003)(478600001)(9686003)(66946007)(38100700002)(30864003)(64756008)(66476007)(5660300002)(8936002)(4326008)(52536014)(66446008)(2906002)(76116006)(44832011)(41300700001)(8676002)(66556008)(53546011)(122000001)(186003)(6506007)(33656002)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTlBQ09NSUVadTNmMjJvZHd1LzdRSkF0b0preDRRaUxWOXFBeHpNUXN1MTdt?=
 =?utf-8?B?d2xsTjFMQWdpbXdXS2c0Tm1qRWo2VDBkTkpPM3hRS2FmUHJVc0NYYVNIeTF4?=
 =?utf-8?B?eTFBalVxc2w5ckxZbzdjL3F3L3NBZUVBWHRwOHNEQmw4NGgvaGl4VmQrc0hU?=
 =?utf-8?B?bDVuOFRnSE1mT3E2WlJoNmR0UTR5NzA1UkJnc2dmWG5nVE45ODE2RTJpSWIw?=
 =?utf-8?B?eXZ3aEpqVjdINllDYlVqSDJEOTJWUDkrVk5JYis4cy9NVWNyNXFkcndod2E5?=
 =?utf-8?B?WWtwU1RWQWNvU1YrSTNuOXdJZzdYVHZhSlNtNk9LaTBJWHh0bUFRb1djdnhk?=
 =?utf-8?B?YTdEUGpjZWt4Nll5TUxTckRpTGhjUUJZNWxselNSNGYvZ3JjRGxnMjZjanZ1?=
 =?utf-8?B?VTNwTDRhVDdVZDlFdlRVSXlpY2xlYjVvd2FCSGUvbFFWN2NvVzM1WHd4UFlD?=
 =?utf-8?B?bTFHbUtGNTdPMkVaeUVEdzBUU2ZoQ2pCcU54VVRlRTFMNUVEZ0JMaUlUMzNC?=
 =?utf-8?B?YXdVNG9hTWt4R09obXVOak9yejRhNUhMZmJoWmRNMUpMZ3MzT1Mva2M5T0Yr?=
 =?utf-8?B?UjY1M1VTTndTVHlpY3dTSnVkR1hnTmRnVHVRRStXaHJKbldHaW9WaVgyc3or?=
 =?utf-8?B?eUdlYk8wNDAzaGlCc1k0SStTaFhOVU9jU09zRGhDRDJKdnhQVzJjYUQwUTFT?=
 =?utf-8?B?Y2MwTHh3ditDbitab3YvYU9UeEkyam1rWWJqdzVYQUx2NjlXYVJyUWxUOVli?=
 =?utf-8?B?Y1lTUE1zVmV2OHdkanBlTHRxZzNoMWdvTnFmcmc3NUluWHlXYWEwV2NHU2NG?=
 =?utf-8?B?aHI2aE9GeHZsZlNEdG82aWFnWkYxdFBJWFVVQ3l5dXdCcmRpUmtWWENSQ3E1?=
 =?utf-8?B?NyszZk1uQlpEZXQvYmJrbnBuTW5hUVJ6UFZEcXJBSXYyM0hCV3VTWmR1dFpl?=
 =?utf-8?B?bVJCajhSbnFvZ0kybXdldmFFdnRlMTBDZU4xWTlycmsxZGxxNkI5Um1NZXl3?=
 =?utf-8?B?RFRLVHlnYnd1cUgwZ0VDNXFrZTdSK0dVTEtxRDE4L0NRSnZrdVVJTGpUNGs4?=
 =?utf-8?B?eVVFeFVMQVNFZWx2ZDd2M3lLQnJOWjRkRW9tTklJYld6VG1ySExuOGUrWTAw?=
 =?utf-8?B?Q1lGMjUrZmhtNFkvUVpISENqOGlsa3dnUkwzVzlvQWNENVMyTzI5YTh2bFBD?=
 =?utf-8?B?M252WDM2N092d2lZbk9wTnZmbUx2SzdpK1dmMElhWUdiR0Z0aGhWNUdobkJI?=
 =?utf-8?B?QmV5VHJaaThHeDdaNStwdDh3eENndWthTVMrek9veGRFc1gwR0hRQi85aDN3?=
 =?utf-8?B?REFSRkUyb2ZFOGM1dEQzVVlicDBwZURUVWZHVy8zWnFLOWJGelZkdEJydjB0?=
 =?utf-8?B?R3BhTWpRT3pQTmhuR0xTY3Yycm96T0dtSG9KN3ZHa0NVTE1mcmdQQXZNRmFt?=
 =?utf-8?B?NEl4OFhzdG5DbHRpV0w1THlCK0xHZlYrWkhRTE9mUHFKM2RITG1qcTRac3BV?=
 =?utf-8?B?Wm9wdlg4MStULy9QM2lWTVhlbFc5aHZqcHVaZzFFeGJuVmFTYjBad2lzdUxG?=
 =?utf-8?B?RzFDS3RGV1VXKzhoOTBLd0djN2drSE5iS3pUc3cwRHFmY0pSV2RRZ3BUNnB2?=
 =?utf-8?B?ZTh4T1RjU3JHVng0d1NmZFliaFM5dVZmWjVpVFprbXlqUWVGeFMrT2RWUXM0?=
 =?utf-8?B?WlZ0eU4rb3ZJQ0FnbHVVRU9NOVBTSDJiR2lBVTlrMGJ4UTUrdzdxdXhEVmtI?=
 =?utf-8?B?NWhMTlNJK1BXYnpmRHZ6d3FIUHNkN0plSVgwYisvWm40OVA5QXJMUEovUFk4?=
 =?utf-8?B?aHc1a1hSSVIxM0d5N3kvQ2Ira1JrajZKYmJralZRVXRjN2VoZDlCazZTVGxj?=
 =?utf-8?B?OGpCTHFQcjlpSWtSdnBZZXcwcWZlcDllTU1VaVpTTElCZWNaWFhmVERnQ21k?=
 =?utf-8?B?Yjd2alJpZGcyVGdYYkszL3l2TnJEelRiS2l2WnJybkhkY0MwZUVUY0tkZkFz?=
 =?utf-8?B?OTJSNWk0NnJkYXNackNnektqZFRnYVUwdHczRHBuRE1FRkJzRmtkemxEdG5V?=
 =?utf-8?B?cUVSSnpJNUhlOWNTbkd5U3MxOHhGNUhhUWFOWG5qbHFUM1IwOEY3RVVnVmRX?=
 =?utf-8?Q?4Q90sADKQtM0SSwXb5O6yO98v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b8b4f0-34a6-4f9c-0161-08daef0f9e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 11:25:58.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLagcN46q0IkywFvx6/M15KqQFeSdPDR+padIdN+oHAQpXhXn9gi65OhlobG4A3jAEQe+RoLA6IHUbYzpLUq8dIUakHzrW7PC5rxcQmFnhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGbG9yaWFuIFdlc3RwaGFsIDxm
d0BzdHJsZW4uZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgNCBKYW51YXJ5IDIwMjMgMTM6NDENCj4g
VG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4gQ2M6
IG5ldGZpbHRlci1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IEZsb3JpYW4gV2VzdHBoYWwgPGZ3QHN0
cmxlbi5kZT47DQo+IE1hcmNlbG8gUmljYXJkbyBMZWl0bmVyIDxtbGVpdG5lckByZWRoYXQuY29t
PjsgTG9uZyBYaW4NCj4gPGx4aW5AcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0hdIG5ldGZpbHRlcjogY29ubnRyYWNrOiBzaW1wbGlmeSBzY3RwIHN0YXRlIG1hY2hpbmUNCj4g
DQo+IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD4gd3JvdGU6
DQo+ID4gQWxsIHRoZSBwYXRocyBpbiBhbiBTQ1RQIGNvbm5lY3Rpb24gYXJlIGtlcHQgYWxpdmUg
ZWl0aGVyIGJ5IGFjdHVhbA0KPiA+IERBVEEvU0FDSyBydW5uaW5nIHRocm91Z2ggdGhlIGNvbm5l
Y3Rpb24gb3IgYnkgSEVBUlRCRUFULiBUaGlzIHBhdGNoDQo+ID4gcHJvcG9zZXMgYSBzaW1wbGUg
c3RhdGUgbWFjaGluZSB3aXRoIG9ubHkgdHdvIHN0YXRlcyBPUEVOX1dBSVQgYW5kDQo+ID4gRVNU
QUJMSVNIRUQgKHNpbWlsYXIgdG8gVURQKS4gVGhlIHJlYXNvbiBmb3IgdGhpcyBjaGFuZ2UgaXMg
YSBmdWxsDQo+ID4gc3RhdGVmdWwgYXBwcm9hY2ggdG8gU0NUUCBpcyBkaWZmaWN1bHQgd2hlbiB0
aGUgYXNzb2NpYXRpb24gaXMNCj4gPiBtdWx0aWhvbWVkIHNpbmNlIHRoZSBlbmRwb2ludHMgY291
bGQgdXNlIGRpZmZlcmVudCBwYXRocyBpbiB0aGUNCj4gPiBuZXR3b3JrIGR1cmluZyB0aGUgbGlm
ZXRpbWUgb2YgYW4gYXNzb2NpYXRpb24uDQo+ID4NCj4gPiBEZWZhdWx0IHRpbWVvdXRzIGFyZToN
Cj4gPiBPUEVOX1dBSVQ6ICAgMyBzZWNvbmRzICAgKHJ0b19pbml0aWFsKQ0KPiA+IEVTVEFCTElT
SEVEOiAyMTAgc2Vjb25kcyAocnRvX21heCArIGhiX2ludGVydmFsICogcGF0aF9tYXhfcmV0cmFu
cykNCj4gPg0KPiA+IEltcG9ydGFudCBjaGFuZ2VzL25vdGVzDQo+ID4gLSBUaW1lb3V0IGlzIHVz
ZWQgdG8gY2xlYW4gdXAgY29ubnRyYWNrIGVudHJpZXMNCj4gPiAtIFZUQUcgY2hlY2tzIGFyZSBr
ZXB0IGFzIGlzIChjYW4gYmUgbW92ZWQgdG8gYSBjb25udHJhY2sgZXh0ZW5zaW9uIGlmDQo+ID4g
ICBkZXNpcmVkKQ0KPiA+IC0gU0NUUCBjaHVua3MgYXJlIHBhcnNlZCBvbmx5IG9uY2UsIGFuZCBh
IG1hcCBpcyBwb3B1bGF0ZWQgd2l0aCB0aGUNCj4gPiAgIGluZm9ybWF0aW9uIG9uIHRoZSBjaHVu
a3MgcHJlc2VudCBpbiB0aGUgcGFja2V0DQo+ID4gLSBBU1NVUkVEIGJpdCBpcyBOT1Qgc2V0IGlu
IHRoaXMgdmVyc2lvbiBvZiB0aGUgcGF0Y2gsIG5lZWQgaGVscA0KPiA+ICAgdW5kZXJzdGFuZGlu
ZyB3aGVuIHRvIHNldCBpdA0KPiA+DQo+ID4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggaGFzIGNoYW5n
ZWQgdWFwaSBoZWFkZXJzLg0KPiANCj4gRG9uJ3QgZG8gdGhhdCBwbGVhc2UsIHRoaXMgd2lsbCBj
YXVzZSB0cm91YmxlLg0KDQpZZXMsIEkgdW5kZXJzdGFuZCwgd2lsbCByZW1vdmUgdGhlIGNoYW5n
ZXMgYW5kIHJldXNlIENPT0tJRV9XQUlUIHZhbHVlIGZvciBPUEVOX1dBSVQuDQoNCj4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50
ZWNoPg0KPiA+IC0tLQ0KPiA+ICAuLi4vdWFwaS9saW51eC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNr
X3NjdHAuaCAgfCAgMTAgKy0NCj4gPiAgLi4uL2xpbnV4L25ldGZpbHRlci9uZm5ldGxpbmtfY3R0
aW1lb3V0LmggICAgIHwgIDEwICstDQo+ID4gIG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX3By
b3RvX3NjdHAuYyAgICAgICB8IDU4OSArKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgbmV0L25ldGZp
bHRlci9uZl9jb25udHJhY2tfc3RhbmRhbG9uZS5jICAgICAgIHwgIDcyICstLQ0KPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCA1MzggZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L25ldGZpbHRlci9uZl9jb25udHJhY2tf
c2N0cC5oDQo+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19z
Y3RwLmgNCj4gPiBpbmRleCBjNzQyNDY5YWZlMjEuLjg5MzgxYTU3MDIxYSAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19zY3RwLmgNCj4g
PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19zY3RwLmgN
Cj4gPiBAQCAtNywxNiArNyw4IEBADQo+ID4NCj4gPiAgZW51bSBzY3RwX2Nvbm50cmFjayB7DQo+
ID4gIAlTQ1RQX0NPTk5UUkFDS19OT05FLA0KPiA+IC0JU0NUUF9DT05OVFJBQ0tfQ0xPU0VELA0K
PiA+IC0JU0NUUF9DT05OVFJBQ0tfQ09PS0lFX1dBSVQsDQo+ID4gLQlTQ1RQX0NPTk5UUkFDS19D
T09LSUVfRUNIT0VELA0KPiA+ICsJU0NUUF9DT05OVFJBQ0tfT1BFTl9XQUlULA0KPiA+ICAJU0NU
UF9DT05OVFJBQ0tfRVNUQUJMSVNIRUQsDQo+ID4gLQlTQ1RQX0NPTk5UUkFDS19TSFVURE9XTl9T
RU5ULA0KPiA+IC0JU0NUUF9DT05OVFJBQ0tfU0hVVERPV05fUkVDRCwNCj4gPiAtCVNDVFBfQ09O
TlRSQUNLX1NIVVRET1dOX0FDS19TRU5ULA0KPiA+IC0JU0NUUF9DT05OVFJBQ0tfSEVBUlRCRUFU
X1NFTlQsDQo+ID4gLQlTQ1RQX0NPTk5UUkFDS19IRUFSVEJFQVRfQUNLRUQsDQo+ID4gLQlTQ1RQ
X0NPTk5UUkFDS19EQVRBX1NFTlQsDQo+ID4gIAlTQ1RQX0NPTk5UUkFDS19NQVgNCj4gDQo+IFBs
ZWFzZSBrZWVwIGFsbCBhcy1pcy4NCj4gDQo+IFlvdSBtaWdodCB3YW50IHRvIGFkZCBhIC8qIG5v
IGxvbmVyIHVzZWQgKi8gb3Igc2ltaWxhci4NCj4gDQo+IFlvdSBjb3VsZCBoaWphY2sgYW4gZXhp
c3RpbmcgZW51bSB0byBhdm9pZCBhZGRpbmcgYSBuZXcgb25lOg0KPiANCj4gU0NUUF9DT05OVFJB
Q0tfT1BFTl9XQUlUID0gU0NUUF9DT05OVFJBQ0tfQ09PS0lFX1dBSVQsDQo+IA0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZmlsdGVyL25mbmV0bGlua19jdHRpbWVvdXQu
aA0KPiA+IGIvaW5jbHVkZS91YXBpL2xpbnV4L25ldGZpbHRlci9uZm5ldGxpbmtfY3R0aW1lb3V0
LmgNCj4gPiBpbmRleCA5NGU3NDAzNDcwNmQuLjM3MmRmZTdjMDdlZCAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZmlsdGVyL25mbmV0bGlua19jdHRpbWVvdXQuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9uZXRmaWx0ZXIvbmZuZXRsaW5rX2N0dGltZW91dC5o
DQo+ID4gQEAgLTg2LDE2ICs4Niw4IEBAIGVudW0gY3RhdHRyX3RpbWVvdXRfZGNjcCB7DQo+ID4N
Cj4gPiAgZW51bSBjdGF0dHJfdGltZW91dF9zY3RwIHsNCj4gPiAgCUNUQV9USU1FT1VUX1NDVFBf
VU5TUEVDLA0KPiA+IC0JQ1RBX1RJTUVPVVRfU0NUUF9DTE9TRUQsDQo+ID4gLQlDVEFfVElNRU9V
VF9TQ1RQX0NPT0tJRV9XQUlULA0KPiA+IC0JQ1RBX1RJTUVPVVRfU0NUUF9DT09LSUVfRUNIT0VE
LA0KPiA+ICsJQ1RBX1RJTUVPVVRfU0NUUF9PUEVOX1dBSVQsDQo+ID4gIAlDVEFfVElNRU9VVF9T
Q1RQX0VTVEFCTElTSEVELA0KPiA+IC0JQ1RBX1RJTUVPVVRfU0NUUF9TSFVURE9XTl9TRU5ULA0K
PiA+IC0JQ1RBX1RJTUVPVVRfU0NUUF9TSFVURE9XTl9SRUNELA0KPiA+IC0JQ1RBX1RJTUVPVVRf
U0NUUF9TSFVURE9XTl9BQ0tfU0VOVCwNCj4gPiAtCUNUQV9USU1FT1VUX1NDVFBfSEVBUlRCRUFU
X1NFTlQsDQo+ID4gLQlDVEFfVElNRU9VVF9TQ1RQX0hFQVJUQkVBVF9BQ0tFRCwNCj4gPiAtCUNU
QV9USU1FT1VUX1NDVFBfREFUQV9TRU5ULA0KPiA+ICAJX19DVEFfVElNRU9VVF9TQ1RQX01BWA0K
PiANCj4gU2FtZSwgdGhpcyBpcyBmcm96ZW4sIHlvdSBjYW4gYWRkIHRvIGl0IGJ1dCB5b3UgY2Fu
bm90IHJlbW92ZSB0aGlzLg0KPiANCj4gWW91IGNhbiBhZGQgYSBrZXJuZWwgaW50ZXJuYWwgZW51
bSBpZiB5b3UgbGlrZSwgdG8gcmVwbGFjZSB0aGUgZXhpc3Rpbmcgb25lcywNCj4gd2l0aCBrZXJu
ZWwgbWFwcGluZyB0aGUgbmV3IG9uZXMgdG8gb2xkIChhbmQgaWdub3JpbmcgdGhlIG9sZCBvbmVz
IG9uIGlucHV0DQo+IGZyb20gdXNlcnNwYWNlKS4NCj4gDQo+IFRoaXMgd291bGQgYWxsb3cgdG8g
c2hyaW5rIHN0cnVjdCBuZl9zY3RwX25ldCBzaXplIGZvciBleGFtcGxlLg0KPiANCj4gPiAgI2Rl
ZmluZSBDVEFfVElNRU9VVF9TQ1RQX01BWCAoX19DVEFfVElNRU9VVF9TQ1RQX01BWCAtIDEpIGRp
ZmYgLS0NCj4gZ2l0DQo+ID4gYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90b19zY3Rw
LmMNCj4gPiBiL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX3Byb3RvX3NjdHAuYw0KPiA+IGlu
ZGV4IGQ4OGI5MmE4ZmZjYS4uZDc5ZWQ0NzZiNzY0IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9uZXRm
aWx0ZXIvbmZfY29ubnRyYWNrX3Byb3RvX3NjdHAuYw0KPiA+ICsrKyBiL25ldC9uZXRmaWx0ZXIv
bmZfY29ubnRyYWNrX3Byb3RvX3NjdHAuYw0KPiA+IEBAIC01LDEyICs1LDEzIEBADQo+ID4gICAq
IENvcHlyaWdodCAoYykgMjAwNCBLaXJhbiBLdW1hciBJbW1pZGkgPGltbWlkaV9raXJhbkB5YWhv
by5jb20+DQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAwNC0yMDEyIFBhdHJpY2sgTWNIYXJkeSA8
a2FiZXJAdHJhc2gubmV0Pg0KPiA+ICAgKg0KPiA+IC0gKiBTQ1RQIGlzIGRlZmluZWQgaW4gUkZD
IDI5NjAuIFJlZmVyZW5jZXMgdG8gdmFyaW91cyBzZWN0aW9ucyBpbg0KPiA+IHRoaXMgY29kZQ0K
PiA+ICsgKiBTQ1RQIGlzIGRlZmluZWQgaW4gUkZDIDQ5NjAuIFJlZmVyZW5jZXMgdG8gdmFyaW91
cyBzZWN0aW9ucyBpbg0KPiA+ICsgdGhpcyBjb2RlDQo+ID4gICAqIGFyZSB0byB0aGlzIFJGQy4N
Cj4gPiAgICovDQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC90aW1lci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvbmV0ZmlsdGVyLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pbi5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaXAuaD4NCj4gPiBAQCAtMjcsMTI3ICsyOCwxOSBAQA0K
PiA+ICAjaW5jbHVkZSA8bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfZWNhY2hlLmg+DQo+ID4g
ICNpbmNsdWRlIDxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja190aW1lb3V0Lmg+DQo+ID4NCj4g
PiAtLyogRklYTUU6IEV4YW1pbmUgaXBmaWx0ZXIncyB0aW1lb3V0cyBhbmQgY29ubnRyYWNrIHRy
YW5zaXRpb25zIG1vcmUNCj4gPiAtICAgY2xvc2VseS4gIFRoZXkncmUgbW9yZSBjb21wbGV4LiAt
LVJSDQo+ID4gLQ0KPiA+IC0gICBBbmQgc28gZm9yIG1lIGZvciBTQ1RQIDpEIC1LaXJhbiAqLw0K
PiA+ICsjZGVmaW5lCVNDVFBfRkxBR19IRUFSVEJFQVRfVlRBR19GQUlMRUQJMQ0KPiA+DQo+ID4g
IHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBzY3RwX2Nvbm50cmFja19uYW1lc1tdID0gew0KPiA+
ICAJIk5PTkUiLA0KPiA+IC0JIkNMT1NFRCIsDQo+ID4gLQkiQ09PS0lFX1dBSVQiLA0KPiA+IC0J
IkNPT0tJRV9FQ0hPRUQiLA0KPiA+ICsJIk9QRU5fV0FJVCIsDQo+ID4gIAkiRVNUQUJMSVNIRUQi
LA0KPiA+IC0JIlNIVVRET1dOX1NFTlQiLA0KPiA+IC0JIlNIVVRET1dOX1JFQ0QiLA0KPiA+IC0J
IlNIVVRET1dOX0FDS19TRU5UIiwNCj4gPiAtCSJIRUFSVEJFQVRfU0VOVCIsDQo+ID4gLQkiSEVB
UlRCRUFUX0FDS0VEIiwNCj4gPiAgfTsNCj4gDQo+ID4gLQl9DQo+ID4gKwlbU0NUUF9DT05OVFJB
Q0tfT1BFTl9XQUlUXQkJCT0gMyBTRUNTLA0KPiA+ICsJW1NDVFBfQ09OTlRSQUNLX0VTVEFCTElT
SEVEXQkJPSAyMTAgU0VDUywNCj4gPiAgfTsNCj4gDQo+ID4NCj4gPiArI2RlZmluZSBmb3JfZWFj
aF9zY3RwX2NodW5rKHNrYiwgc2NoLCBfc2NoLCBvZmZzZXQsIGRhdGFvZmYsIGNvdW50KQlcDQo+
ID4gK2ZvciAoKG9mZnNldCkgPSAoZGF0YW9mZikgKyBzaXplb2Yoc3RydWN0IHNjdHBoZHIpLCAo
Y291bnQpID0gMDsJXA0KPiA+ICsJKG9mZnNldCkgPCAoc2tiKS0+bGVuICYmCQkJCQlcDQo+IA0K
PiBJIHRoaW5rIHNrYl9oZWFkZXJfcG9pbnRlcigpIHdpbGwgcmV0dXJuIE5VTEwgaWYgb2Zmc2V0
ICsgc2l6ZW9mKF9zY2gpIGV4Y2VlZHMNCj4gc2tiLT5sZW4sIHNvIHRoaXMgb2Zmc2V0IDwgc2ti
LT5sZW4gdGVzdCBpcyByZWR1bmRhbnQuDQo+IA0KPiA+ICsJKG9mZnNldCkgKz0gKG50b2hzKChz
Y2gpLT5sZW5ndGgpICsgMykgJiB+MywgKGNvdW50KSsrKQ0KPiANCj4gV2hhdCBpZiBzY2gtPmxl
bmd0aCA9PSAwPw0KDQpPb3BzLCBpbmZpbml0ZSBsb29wLiBJIHdpbGwgZml4IGl0Lg0KDQo+IA0K
PiA+ICsJZm9yX2VhY2hfc2N0cF9jaHVuayAoc2tiLCBzY2gsIF9zY2gsIG9mZnNldCwgZGF0YW9m
ZiwgY291bnQpIHsNCj4gPiArCQlwcl9kZWJ1ZygiQ2h1bmsgTnVtOiAlZCAgVHlwZTogJWRcbiIs
IGNvdW50LCBzY2gtPnR5cGUpOw0KPiANCj4gSXMgdGhpcyBwcl9kZWJ1ZygpIG5lZWRlZD8gIEl0
cyBwcmV0dHkgdXNlbGVzcyBiZWNhdXNlIGl0IHdvdWxkIHByaW50IGZvciBldmVyeQ0KPiBwYWNr
ZXQgKGl0cyBub3QgYW4gZXJyb3IgcGF0aCkuDQoNClJlbW92ZWQgbm93Lg0KDQo+IA0KPiA+ICsJ
CXNldF9iaXQoc2NoLT50eXBlLCBtYXApOw0KPiA+DQo+ID4gLQlpZiAoZG9fYmFzaWNfY2hlY2tz
KGN0LCBza2IsIGRhdGFvZmYsIG1hcCkgIT0gMCkNCj4gPiAtCQlnb3RvIG91dDsNCj4gPiArCQlp
ZiAoc2NoLT50eXBlID09IFNDVFBfQ0lEX0lOSVQgfHwNCj4gPiArCQkJc2NoLT50eXBlID09IFND
VFBfQ0lEX0lOSVRfQUNLKSB7DQo+ID4gKwkJCXN0cnVjdCBzY3RwX2luaXRoZHIgX2luaXRoLCAq
aW5pdGg7DQo+ID4gKwkJCWluaXRoID0gc2tiX2hlYWRlcl9wb2ludGVyKHNrYiwgb2Zmc2V0ICsg
c2l6ZW9mKF9zY2gpLA0KPiA+ICsJCQkJCQlzaXplb2YoX2luaXRoKSwgJl9pbml0aCk7DQo+ID4g
KwkJCWlmIChpbml0aCkNCj4gPiArCQkJCWluaXRfdnRhZyA9IGluaXRoLT5pbml0X3RhZzsNCj4g
PiArCQkJZWxzZQ0KPiA+ICsJCQkJZ290byBvdXRfZHJvcDsNCj4gDQo+IAkJCWlmICghaW5pdGgp
DQo+IAkJCQlnb3RvIG91dF9kcm9wOw0KPiANCj4gCQkJaW5pdF92dGFnID0gaW5pdGgtPmluaXRf
dGFnOw0KPiANCj4gQWxzbywgcGxlYXNlIHJ1biB5b3VyIHBhdGNoIHRocm91Z2ggc2NyaXB0cy9j
aGVja3BhdGNoLnBsIHNjcmlwdCwgSSdtIHN1cmUNCj4gdGhlcmUgYXJlIHNldmVyYWwgY29kaW5n
IHN0eWxlIHdhcm5pbmdzIGhlcmUuDQo+IA0KPiA+ICsJc3Bpbl9sb2NrX2JoKCZjdC0+bG9jayk7
DQo+IA0KPiBXaHkgaXMgdGhpcyBzcGlubG9jayBuZWVkZWQ/DQoNCkkgaGF2ZSByZXdvcmtlZCB0
aGUgY29kZSBhIGJpdCBub3csIGFuZCB3aWxsIHVzZSB0aGUgc3BpbmxvY2sgb25seSBmb3IgdGhl
IHBhcnRzIHRoYXQgd3JpdGUgdG8gY3QuDQoNCj4gDQo+ID4gIAlpZiAoIW5mX2N0X2lzX2NvbmZp
cm1lZChjdCkpIHsNCj4gPiAgCQkvKiBJZiBhbiBPT1RCIHBhY2tldCBoYXMgYW55IG9mIHRoZXNl
IGNodW5rcyBkaXNjYXJkIChTZWMgOC40KQ0KPiAqLw0KPiA+ICAJCWlmICh0ZXN0X2JpdChTQ1RQ
X0NJRF9BQk9SVCwgbWFwKSB8fA0KPiA+ICAJCSAgICB0ZXN0X2JpdChTQ1RQX0NJRF9TSFVURE9X
Tl9DT01QTEVURSwgbWFwKSB8fA0KPiA+ICAJCSAgICB0ZXN0X2JpdChTQ1RQX0NJRF9DT09LSUVf
QUNLLCBtYXApKQ0KPiA+IC0JCQlyZXR1cm4gLU5GX0FDQ0VQVDsNCj4gPiArCQkJZ290byBvdXRf
dW5sb2NrOw0KPiA+DQo+ID4gLQkJaWYgKCFzY3RwX25ldyhjdCwgc2tiLCBzaCwgZGF0YW9mZikp
DQo+ID4gLQkJCXJldHVybiAtTkZfQUNDRVBUOw0KPiANCj4gQW55IHJlYXNvbiBmb3IgZGVsZXRp
bmcgc2N0cF9uZXcoKT8NCj4gSXQgbWFrZXMgdGhpcyBib2R5IGEgbG90IGxhcmdlciwgdGhlIGxp
bmVzIGJlbG93IGNvdWxkIGhhdmUgYmVlbiBkb25lIGluDQo+IHNjdHBfbmV3KCkuDQoNCkkgd2ls
bCBicmluZyBiYWNrIHNjdHBfbmV3KCkgYW5kIG1vdmUgdnRhZyBjaGVja3MgaW50byBpdHMgb3du
IGZ1bmN0aW9uIHNjdHBfdnRhZ19jaGVjaygpLg0KDQo+IA0KPiA+ICsJCW1lbXNldCgmY3QtPnBy
b3RvLnNjdHAsIDAsIHNpemVvZihjdC0+cHJvdG8uc2N0cCkpOw0KPiA+ICsJCWN0LT5wcm90by5z
Y3RwLnN0YXRlID0gU0NUUF9DT05OVFJBQ0tfT1BFTl9XQUlUOw0KPiA+ICsJCW5mX2Nvbm50cmFj
a19ldmVudF9jYWNoZShJUENUX1BST1RPSU5GTywgY3QpOw0KPiA+ICsNCj4gPiArCQlpZiAodGVz
dF9iaXQoU0NUUF9DSURfSU5JVCwgbWFwKSkNCj4gPiArCQkJY3QtPnByb3RvLnNjdHAudnRhZ1sh
ZGlyXSA9IGluaXRfdnRhZzsNCj4gPiArCQllbHNlIGlmICh0ZXN0X2JpdChTQ1RQX0NJRF9TSFVU
RE9XTl9BQ0ssIG1hcCkpDQo+ID4gKwkJCS8qIElmIGl0IGlzIGEgc2h1dGRvd24gYWNrIE9PVEIg
cGFja2V0LCB3ZSBleHBlY3QgYQ0KPiByZXR1cm4NCj4gPiArCQkJc2h1dGRvd24gY29tcGxldGUs
IG90aGVyd2lzZSBhbiBBQk9SVCBTZWMgOC40ICg1KQ0KPiBhbmQgKDgpICovDQo+ID4gKwkJCWN0
LT5wcm90by5zY3RwLnZ0YWdbIWRpcl0gPSBzY3RwaC0+dnRhZzsNCj4gPiArCQllbHNlDQo+ID4g
KwkJCWN0LT5wcm90by5zY3RwLnZ0YWdbZGlyXSA9IHNjdHBoLT52dGFnOw0KPiANCj4gTWF5YmUg
dGhlIGVsc2UgYnJhbmNoIGJlbG93IGNhbiBiZSBlbGlkZWQgYnkgYWRkaW5nIGEgZ290byBoZXJl
Pw0KPiANCj4gQUZBSUNTIHRoZSBzcGlubG9jayBpcyBvbmx5IG5lZWRlZCBmb3Igc29tZSBwYXJ0
cyBvZiB0aGUgZWxzZSBicmFuY2gsIHNvIHRoZQ0KPiBzcGluX2xvY2tfYmggY2FuIGJlIG1vdmVk
Lg0KPiA+ICsJCS8qIHdlIGhhdmUgc2VlbiB0cmFmZmljIGJvdGggd2F5cywgZ28gdG8gZXN0YWJs
aXNoZWQgKi8NCj4gPiArCQlpZiAoZGlyID09IElQX0NUX0RJUl9SRVBMWSAmJg0KPiA+ICsJCQlj
dC0+cHJvdG8uc2N0cC5zdGF0ZSA9PQ0KPiBTQ1RQX0NPTk5UUkFDS19PUEVOX1dBSVQpIHsNCj4g
PiArCQkJY3QtPnByb3RvLnNjdHAuc3RhdGUgPQ0KPiBTQ1RQX0NPTk5UUkFDS19FU1RBQkxJU0hF
RDsNCj4gPiArCQkJbmZfY29ubnRyYWNrX2V2ZW50X2NhY2hlKElQQ1RfUFJPVE9JTkZPLCBjdCk7
DQo+IA0KPiA+ICsJLyogQ2hlY2sgdGhlIHZlcmlmaWNhdGlvbiB0YWcgKFNlYyA4LjUpICovDQo+
ID4gKwlpZiAoIXRlc3RfYml0KFNDVFBfQ0lEX0lOSVQsIG1hcCkgJiYNCj4gPiArCQkhdGVzdF9i
aXQoU0NUUF9DSURfU0hVVERPV05fQ09NUExFVEUsIG1hcCkgJiYNCj4gPiArCQkhdGVzdF9iaXQo
U0NUUF9DSURfQ09PS0lFX0VDSE8sIG1hcCkgJiYNCj4gPiArCQkhdGVzdF9iaXQoU0NUUF9DSURf
QUJPUlQsIG1hcCkgJiYNCj4gPiArCQkhdGVzdF9iaXQoU0NUUF9DSURfU0hVVERPV05fQUNLLCBt
YXApICYmDQo+ID4gKwkJIXRlc3RfYml0KFNDVFBfQ0lEX0hFQVJUQkVBVCwgbWFwKSAmJg0KPiA+
ICsJCSF0ZXN0X2JpdChTQ1RQX0NJRF9IRUFSVEJFQVRfQUNLLCBtYXApICYmDQo+ID4gKwkJc2N0
cGgtPnZ0YWcgIT0gY3QtPnByb3RvLnNjdHAudnRhZ1tkaXJdKSB7DQo+ID4gKwkJcHJfZGVidWco
IlZlcmlmaWNhdGlvbiB0YWcgY2hlY2sgZmFpbGVkXG4iKTsNCj4gDQo+IFBsZWFzZSBoYXZlIGEg
bG9vayBhdA0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbmV0ZmlsdGVy
LQ0KPiBkZXZlbC9wYXRjaC8yMDIzMDEwMjExNDYxMi4xNTg2MC0yLWZ3QHN0cmxlbi5kZS8NCj4g
DQo+IEkgaG9wZSBpdCB3aWxsIGJlIGFwcGxpZWQgc2hvcnRseSBzbyB5b3UgY2FuIHJlYmFzZS4N
Cj4gSSBkb24ndCBoYXZlIGFueSBvdGhlciBzY3RwIHBhdGNoZXMuDQo+IA0KPiBUaGlzIHNob3Vs
ZCBiZQ0KPiBuZl9jdF9sNHByb3RvX2xvZ19pbnZhbGlkKHNrYiwgY3QsIHN0YXRlLA0KPiAJCQkg
ICJ2ZXJpZmljYXRpb24gdGFnIGNoZWNrIGZhaWxlZCAleCB2cyAleCBmb3IgZGlyICVkIiwNCj4g
CQkJICBzaC0+dnRhZywgY3QtPnByb3RvLnNjdHAudnRhZ1tkaXJdLCBkaXIpOw0KPiANCj4gaW5z
dGVhZCBvZiBwcl9kZWJ1ZygpLg0KDQpZZXMsIHdpbGwgZG8uIFdpbGwgYWxzbyByZW1vdmUgb3Ro
ZXIgcHJfZGVidWcoKSBpZiBhbnkuDQoNCj4gDQo+ID4gKwkvKiBTcGVjaWFsIGNhc2VzIG9mIFZl
cmlmaWNhdGlvbiB0YWcgY2hlY2sgKFNlYyA4LjUuMSkgKi8NCj4gDQo+IFBsZWFzZSBleHRlbmQg
dGhlIGNvbW1lbnRzIGEgYml0IHNvIEkgZG9uJ3QgaGF2ZSB0byBsb29rIGF0IHRoZSBSRkMgd2hp
bGUNCj4gcmV2aWV3aW5nLCBqdXN0IHF1b3RlIHRoZSByZWxldmFudCBwYXJ0LCBpLmUuDQo+IA0K
PiA+ICsJaWYgKHRlc3RfYml0KFNDVFBfQ0lEX0lOSVQsIG1hcCkpIHsNCj4gPiArCQkvKiBTZWMg
OC41LjEgKEEpICovDQo+ID4gKwkJaWYgKHNjdHBoLT52dGFnICE9IDApDQo+ID4gIAkJCWdvdG8g
b3V0X3VubG9jazsNCj4gPiAtCQl9DQo+IA0KPiBpZiAoc2N0cGgtPnZ0YWcgIT0gMCkgLyogQSkg
aW5pdCB2dGFnIE1VU1QgYmUgMCAqLw0KPiAJZ290byBvdXRfdW5sb2NrOw0KPiDDtg0KPiA+ICsJ
CWVsc2UgaWYgKG5mX2N0X2lzX2NvbmZpcm1lZChjdCkpDQo+IA0KPiBObyBuZWVkIHRvICdlbHNl
IGlmJywganVzdCB1c2UgJ2lmJy4NCj4gDQo+ID4gKwkvKiBOZWVkIHNvbWUgdGhvdWdodCBvbiBo
b3cgdG8gc2V0IHRoZSBhc3N1cmVkIGJpdCAqLw0KPiA+ICsJLy8gaWYgKGRpciA9PSBJUF9DVF9E
SVJfUkVQTFkgJiYNCj4gPiArCS8vIAkhKHRlc3RfYml0KElQU19BU1NVUkVEX0JJVCwgJmN0LT5z
dGF0dXMpKSkgew0KPiA+ICsJLy8gCSAgc2V0X2JpdChJUFNfQVNTVVJFRF9CSVQsICZjdC0+c3Rh
dHVzKTsNCj4gPiArCS8vIAkgIG5mX2Nvbm50cmFja19ldmVudF9jYWNoZShJUENUX0FTU1VSRUQs
IGN0KTsNCj4gDQo+IFByb2JhYmx5IGRvIGEgdGVzdF9hbmRfc2V0X2JpdCgpIHdoZW4gdGhlIGNv
bm5lY3Rpb24gc3dpdGNoZXMgdG8NCj4gRVNUQUJMSVNIRUQ/DQoNCk9rLCBtYWtlcyBzZW5zZS4N
Cg0KPiANCj4gPiAgc2N0cF90aW1lb3V0X25sYV9wb2xpY3lbQ1RBX1RJTUVPVVRfU0NUUF9NQVgr
MV0gPSB7DQo+ID4gLQlbQ1RBX1RJTUVPVVRfU0NUUF9DTE9TRURdCQk9IHsgLnR5cGUgPSBOTEFf
VTMyIH0sDQo+ID4gLQlbQ1RBX1RJTUVPVVRfU0NUUF9DT09LSUVfV0FJVF0JCT0geyAudHlwZSA9
IE5MQV9VMzIgfSwNCj4gPiAtCVtDVEFfVElNRU9VVF9TQ1RQX0NPT0tJRV9FQ0hPRURdCT0geyAu
dHlwZSA9IE5MQV9VMzIgfSwNCj4gPiArCVtDVEFfVElNRU9VVF9TQ1RQX09QRU5fV0FJVF0JCT0g
eyAudHlwZSA9IE5MQV9VMzIgfSwNCj4gPiAgCVtDVEFfVElNRU9VVF9TQ1RQX0VTVEFCTElTSEVE
XQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LA0KPiA+IC0JW0NUQV9USU1FT1VUX1NDVFBfU0hVVERP
V05fU0VOVF0JPSB7IC50eXBlID0gTkxBX1UzMiB9LA0KPiA+IC0JW0NUQV9USU1FT1VUX1NDVFBf
U0hVVERPV05fUkVDRF0JPSB7IC50eXBlID0gTkxBX1UzMiB9LA0KPiA+IC0JW0NUQV9USU1FT1VU
X1NDVFBfU0hVVERPV05fQUNLX1NFTlRdCT0geyAudHlwZSA9IE5MQV9VMzIgfSwNCj4gPiAtCVtD
VEFfVElNRU9VVF9TQ1RQX0hFQVJUQkVBVF9TRU5UXQk9IHsgLnR5cGUgPSBOTEFfVTMyIH0sDQo+
ID4gLQlbQ1RBX1RJTUVPVVRfU0NUUF9IRUFSVEJFQVRfQUNLRURdCT0geyAudHlwZSA9IE5MQV9V
MzIgfSwNCj4gPiAtCVtDVEFfVElNRU9VVF9TQ1RQX0RBVEFfU0VOVF0JCT0geyAudHlwZSA9IE5M
QV9VMzIgfSwNCj4gDQo+IFBsZWFzZSByZXRhaW4gdGhpcyBhcy1pcyBmb3Igbm93Lg0KPiANCj4g
SSdtIGZpbmUgd2l0aCByZW1vdmluZyB0aGUgc3lzY3RscyB0aG91Z2guDQo=
