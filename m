Return-Path: <netfilter-devel+bounces-5791-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E1A10059
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2025 06:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C671887BCF
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2025 05:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975F20F095;
	Tue, 14 Jan 2025 05:32:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77924025D
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jan 2025 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832730; cv=fail; b=ZwENIWnIcwqIDkM+ZN94NYwmg+ud5h4Ihe2m8FHpv/0fdpzp1tVleoQdzTSDxEch0vclzbQ23EKX8QrFexNEm5EGQcxOV/pZE+yA6jlvWNew1TDoDbYe7h9ppXErCaKimv2aqDF+dYlVpgz1s+Fn++ZIbaiw4ugAn1kHK9zTEK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832730; c=relaxed/simple;
	bh=pjXBs+36QR+1cAXdqRV4RNfDljaDYz/0nU3JT6mqFDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOt2tMhhv8WurU2siuXcCwyP+MNp/1TU2cGLYuQgrfv1fgELmolrjC7PoRf6i1fQKe3pLImaVGHBOXmH8YwYeBK4HklSz5mKLtNioeBBw+LLrpIjT0z+f4T2RfYn4XZkPbKjKJVbECAXsYldKHxIVBP/SzCskm8Pt9jHZoYvtdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.51 with ESMTP; 14 Jan 2025 14:02:04 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hongsik.jo@lge.com
Received: from unknown (HELO sniperexo2.lge.com) (165.244.66.182)
	by 156.147.1.121 with ESMTP; 14 Jan 2025 14:02:04 +0900
X-Original-SENDERIP: 165.244.66.182
X-Original-MAILFROM: hongsik.jo@lge.com
Received: from unknown (HELO SLXP216CU001.outbound.protection.outlook.com) (40.93.138.28)
	by 165.244.66.182 with ESMTP; 14 Jan 2025 14:03:09 +0900
X-Original-SENDERIP: 40.93.138.28
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: hongsik.jo@lge.com
X-Original-RCPTTO: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIJgC7LslEv9X3aKTPsd3Y2PGgex1zwwyoZ73D3tcK7xF4vTuhk5PFMRt8CtQPUVX/FnAXWZPJIwM8lmfVYkNUZL9A0cIJ3kVz9L4ytzHNpXa76En22C+ZWiA1SsFfAJg42cXmmAuoJ5sgIo+koLtzi0ybwcOCfZB73cA4YEv8stbe6sevei5ets2XkRiMCOx7NCFxD5rezcXSZewCTzkA7FFb3q6OqOYrfzmdhpVVmQMaElf6u5JaAK8SyYFiZyDfMj+0/+FG9f97d1P5a/6kjE/3k9j/weob678GOLE83waUHJu+QMEqhs0MgT6LHzhVYA4qLUSB8EDSF/AIWCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjXBs+36QR+1cAXdqRV4RNfDljaDYz/0nU3JT6mqFDM=;
 b=VPQUonD9/2L4OynbT6PGcwVyENTOcnaYaPMj9ycipDsuOkZJWpjCd20Rv/AKs7A7MEib8bJJdE2i6Wr6aUYVejEL9w740IaWctmDSNbS6snWHPezJiMSHRQt4WIZbQP9ci2Gj6UMzMP9MSO5+5AoPsXa/kINpbYmtcK49asAg4tzx81iBjhy5jy1hYRr3BgQApf6kldJ+MIFcosaVuwgfZJFyZDUhtmCMZd56elE2epcfbIbmWhHEqvJMLMgpZZM8zIXmmMOSth9P9oVpol7K21WpzCzSaVQW6mzQ7voDuVDcRgxRtACtdNSw/wO3+LcI/7dDpPNcYREqjxXgoSTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB1558.KORP216.PROD.OUTLOOK.COM (2603:1096:101:28::7) by
 SE1P216MB2022.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 05:02:02 +0000
Received: from SE1P216MB1558.KORP216.PROD.OUTLOOK.COM
 ([fe80::cdf9:f1be:d666:7315]) by SE1P216MB1558.KORP216.PROD.OUTLOOK.COM
 ([fe80::cdf9:f1be:d666:7315%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 05:02:02 +0000
From: =?utf-8?B?7KGw7ZmN7IudL+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuwnA==?=
 =?utf-8?B?7IukIFNXIFNlY3VyaXR5IFRQ?= <hongsik.jo@lge.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
CC: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	=?utf-8?B?7IaQ7JiB7IStL+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuwnA==?=
 =?utf-8?B?7IukIFNXIFNlY3VyaXR5IFRQ?= <loth.son@lge.com>,
	=?utf-8?B?64Ko7KCV7KO8L+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuwnA==?=
 =?utf-8?B?7IukIFNXIFNlY3VyaXR5IFRQ?= <jungjoo.nahm@lge.com>,
	=?utf-8?B?7KCV7J6s7JykL1Rhc2sgTGVhZGVyL1NXIFBsYXRmb3JtKOyXsCnshKDtlolQ?=
 =?utf-8?B?bGF0Zm9ybeqwnOuwnOyLpCDsi5zsiqTthZxTVyBUYXNr?=
	<jaeyoon.jung@lge.com>
Subject: Re: Symbol Collision between ulogd and jansson
Thread-Topic: Symbol Collision between ulogd and jansson
Thread-Index: AQHbZYUZeSfuxQZz00yVbYxjbJSvM7MVSF+AgABtupuAAAFh1w==
Date: Tue, 14 Jan 2025 05:02:02 +0000
Message-ID:
 <SE1P216MB1558DE711072EB45586862918F182@SE1P216MB1558.KORP216.PROD.OUTLOOK.COM>
References:
 <SE1P216MB155825DDA1CD5809E1569DDE8F1F2@SE1P216MB1558.KORP216.PROD.OUTLOOK.COM>
 <Z4WSRVQPmmYfpqvV@calendula>
 <SE1P216MB1558D45C17B9EFF9176AC5C38F182@SE1P216MB1558.KORP216.PROD.OUTLOOK.COM>
In-Reply-To:
 <SE1P216MB1558D45C17B9EFF9176AC5C38F182@SE1P216MB1558.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1558:EE_|SE1P216MB2022:EE_
x-ms-office365-filtering-correlation-id: 1f3b92d6-ed50-4306-edb8-08dd34589590
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yy9Za29NcEdLZW5hZC9EOFhPUFpoaWRKaW9vekpONjNSbk9yUkNKQW1QWEk1?=
 =?utf-8?B?UnM4aEg5SnlNaDluVEdIM1lnd3FIcUh3TmFjUDVuZHIxNC9xNWRuUWpkTWJz?=
 =?utf-8?B?Nlh3R2dkYkNRQlQ1TnFZdFQyZzNWS2FDQldNOHRzVCt1S0NZcFdrN3N3RmRQ?=
 =?utf-8?B?cjZmSS9TODN4UmtQL0NMNGcyOUZOWUpxQkVZUS91ZXNhSEFzeElQMFRlQU04?=
 =?utf-8?B?MXgrdTJ0UE5tRFJWRVVBRVM4aXEvd0s1VktwSE9jKzJuRVN4cGFWUzlCbzk1?=
 =?utf-8?B?Z3M1aTl2djJOV0Rjd1FXQTJNUTdTS0ZpWVJIdFZ0MEhucTd6bExKQnE0MVZS?=
 =?utf-8?B?K0pXeVV5MDl4N0pEbVRtVHRCcmw2K1VybXpWb0JURG13SWJabFpoQU5maFIx?=
 =?utf-8?B?dk1HZFNuRm1XUWdSTWUyZVlyTXF6T3VpaWc2Y0IranNWZWVNejdPUWg2ZDkv?=
 =?utf-8?B?NllhczZHM3VFVktiaC9oMzhNK2s4bkdraTk2Nzh4dVNGbVBkYXBMSVNnKzkv?=
 =?utf-8?B?T25HNXA3dUdjd29vTXFsdTNOd1Jxek5vZlFmcTNCL0hCZHpTblE1a25HYUpa?=
 =?utf-8?B?SDd6M0JUc2cya08rR0lFaEtxWElNMmtRNHZ3Um90aTB2Si9UK1VrbUcyZk85?=
 =?utf-8?B?WkJ0eDlrQk9JdURzZ0p5b3JneGdhT3RieVE3dis3d1ovYzVDVkhiQmI2dCtK?=
 =?utf-8?B?RWt2d3VRSWFBanJ2M3NVOUJlajh5RkNMaDcxZEovMXB2Sk5NS3V2N2c5clor?=
 =?utf-8?B?N1VKK0JNT25wMHdWSnRTS1FHRlo2R29SQ2JjK0NFa2Jja1psYmFsdjZsOGZ3?=
 =?utf-8?B?cGV0YWp3eVFnUW9WUDlBWFlJaXRNbXlHaUVJVjJZeDlKVXlFNlAyZzJMVUMz?=
 =?utf-8?B?WEhGdC92ZHlSQld2eGJ5aEJlTlIvNkZZNWk0Sy9RWDBvWmJ4OEtVcURGV0FN?=
 =?utf-8?B?NlBZNEJxeE1rUTBvT3p1RW9McCthUWF5aU51b3JZa203eVFnalIwZkdoc0Rv?=
 =?utf-8?B?a01mZHdlMWJ2eklRTjFZbFlINlBwTW5zSkVpV1NDb3JVTk1EbGtlLzNZcUJ1?=
 =?utf-8?B?UHI1aHhVVXpGRGgyNTdLWk1YK1FNUWZKWlF5UDd5bWE5QWpTYmlqR3dDWTdV?=
 =?utf-8?B?RHBXd3JiWUNJcUlqZEFKakplT0luVEZTby9XMXB6U3NNNE93OFZYTUh0ZjAz?=
 =?utf-8?B?YlRndVhPV3lyTENXQysvYVRsaGVKYW1MWnJvVW90aTJYZnNZK2dUY2hhQlhG?=
 =?utf-8?B?aHJvYm1TZjczRnJjZzQ2eDI0M3p0dk5XN0lyU1A5aEx2ZjBoVzdKVlI4NXpm?=
 =?utf-8?B?bWJRa1RWQVFJRmVvL2VWL0NEaklWRndVQjF5YlduVUY1YXFnQ3cvNjd4UVNU?=
 =?utf-8?B?YjJET09hMXo0NjNMM04yb2VaNFA0SGxJNWlRVWpvS1NBTXZQQlpUUkV4ZjNa?=
 =?utf-8?B?MUUxeEc3QmVWcERxd2JZUEgwOC81aDh3Wkh0VFkyMTNmQmMyRmVFZk11bmRh?=
 =?utf-8?B?d3U4ZzZabk9heDZaS2NYS1h1QldoUVM4Nnd2dkt2OVpvSG9tZkVCSmpMOWQ1?=
 =?utf-8?B?QUVoLzB3d29VcXI4NndXcVJIajBhMkZWTDArdTBUTWZSYVB1a3Fha2U1V08z?=
 =?utf-8?B?SVdtaGY0K3B1aUZoMlhNR3c3RndURm83QVZSR0tHUGNtalhFN1BXREU5K0Fh?=
 =?utf-8?B?aHA0M3phOEN4NEErWkltNS8xYU9BTEQybklTZFZMTUVCdi95TnU3aXZDSnlY?=
 =?utf-8?B?azA0bnM4cmdzMS9zTWxVTEw2OWxhZUlPSmcreWVLcmNSR0Y4aXg4Z1dTRVF2?=
 =?utf-8?B?VWFPR2ZIMXFnQWFldksrYXJlaEhjYURpQXB2SW0yUXNTNWxUUDJCaDJDa2NR?=
 =?utf-8?B?TjVlY0lTYVF1NlMwamVOSS9sNW5kYVZ5RjBXeUJLZnRhTk9BNHlTMlU0bVQv?=
 =?utf-8?Q?d+L0lqt568LvRq5qNmQrYm84E8GmUprP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1558.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVVlQWpFT0hOdldWZEhLQnUrSk0vRnpBWjY5cFFDSHlISmlSNlc3bDlEVE5Y?=
 =?utf-8?B?WHcyYTZxL0hVRFcySTl6OGlWQnd5ci9zcCt4OXlNUnM3WnFOTU45OXFreER0?=
 =?utf-8?B?TWhQMnpnajFlZkhGL0w3NDBuaXNFb2VxSmF6NC91K213SStmMnRraVk1R3N6?=
 =?utf-8?B?U1hKeU9Ub1hzbG0reHlBWCtKSTFzaDdJWk96L2x3cVFudDhnZHVBdVY4aDZj?=
 =?utf-8?B?VUUrM29ra3ZoaWdRWVVTMExYZTRQbHZqS293akt3aHlLSzI0RGJZOHlDalI0?=
 =?utf-8?B?bnFlS29zdDV2eS8zSFUvOGlHZ1o2UXpab0ZxcGVsWEt3ajZ6STN1ZXFsZWxt?=
 =?utf-8?B?eUlIZVlDclNuajhUYjVzVGltcmVoTnFCVU5pZVZVQmJIVU1oZWNzc3BoQ3Fv?=
 =?utf-8?B?VmpUTS9YRW1ZNUYrZk1JOGlaaEdkUGd6bVNzSHVVaVNLcC9DQ1EzYjBnMW5H?=
 =?utf-8?B?dUUwMno4Z0NCaHpaZWFOSzFNWnM3YnRWd0NSS0VIWGZFcHk2Uisxd0JVVlJj?=
 =?utf-8?B?ZEt1MnFwc21MTlJqc2VaS0dIck1CeDlDalA2U0ZNZFNmZFhoTGxqTU9BaUZJ?=
 =?utf-8?B?NjhHbm9zbnY0NEJRUVNKK2ZlUy9Oc3FWTzhOeHl0WW10NEZ1TmEzdDlxR1VT?=
 =?utf-8?B?MFAxWnlCNjJSSVlQanExVDUxRjAwNjVmMzhuNVFkVVYxSllsenI1NjlZWDhP?=
 =?utf-8?B?SkFoS0orQVIveVY5WmhUWE1oa0ozWWdCWWcwRWFSaXUyaDRZK2xHMmlwTlFN?=
 =?utf-8?B?RjhhbHAzUDl4TGd4bm5xejRWV3EvSFlhbldFTVVoMmpiVnBUVzF0d1FBamRu?=
 =?utf-8?B?cVVhZ2Mva01saDFVN1pyVE1HTC9RbmlTVyt5VGhha3N2QWpWS1I0ZlFpc2ho?=
 =?utf-8?B?UjMyazdkL2ZVY1FwL0tzNjlLMnk2dVBKZExKNHhFamxVMkhKbko5ZEU1eGFC?=
 =?utf-8?B?ZXo2UWU1NUNWTFlWOVg2djZyemJYdzZnU24wYVFIRXlaRDVWNUJyeG5rMUp3?=
 =?utf-8?B?MTdkeG0zUWFmMkVPbXg0cmtrU2dZZkhwSnhSUGIrMTdwMjhWT0lXeTJhcm8w?=
 =?utf-8?B?Lzd6WWNGcmtTMXd3cWsvZDRjcmhTenVUSGN4YWc0MDVxeE1IY2VvNmVtWFdM?=
 =?utf-8?B?ZVlqSFpXWHJrYW5SUytJdzNtc1dtQUZnOW1RWVA5WkxBekhUNm1PNnRLd2dD?=
 =?utf-8?B?OUQyTnBDTldWQ05HWlVQZ2xIcWRlNGxxRlpIQ2dGZGVKSWZXMXVHTXJ1alhj?=
 =?utf-8?B?WTN2Vy9PbXpPVllLMFNQMzZFRGlFVmowb0JIMkxYZkN5WUptR1h5UkU3WlBL?=
 =?utf-8?B?cDFlclhOY3N5ZjROcnlyZ3lZczdrRm8wTHRtZEhsYnBvVFc4QVh2Z0VQcTdp?=
 =?utf-8?B?Nlc2MjFhWEZPMUd3Nk1rUnFyVit1VC9ybXc4NU0xNW1XVW9uVXRsYVFXaW9v?=
 =?utf-8?B?Y0ROU3B5MVk2bzdPT2FqcDcxWGt6amg0MERTT1F6Sk9FK0FKNUxJdlhhS2Zq?=
 =?utf-8?B?bUo4aEVDYlBZZE1tQTJ0N1UvUGVuaTBLSmdWRVZjdERPS01IVHExemZWa1Rs?=
 =?utf-8?B?K2w2Z3p2cWZRRkFpQ0tUVHg0bXJmeitzVGxray9ZUTRWL0hRK0U4bGh2Uys0?=
 =?utf-8?B?YTRYd21Td3YwUHNEbGl1Unpub3VxY09KRkdVWjhNU25tSzY1Z29QM1U5eklI?=
 =?utf-8?B?dGtuckZSRkNKL2ZRTk94U1g3REk4ajh3cGtMK3FLMXBUb0RUVkZYcWlwMlR6?=
 =?utf-8?B?LzYrSnNKY2tvZS9SYnV1L3Q3cmp4dXYwYWJrbGtnOXF5Mkx2L2tWb08vYmRw?=
 =?utf-8?B?QS93eHpRTjRzWm1sczlRZGpKTDRteDZBdmlPaElKS2tNK1BRRkt6T2JrWHN0?=
 =?utf-8?B?V2JldENJYW55c2xVS013VHBodnhwZjBhd2x0eUxIUEVpOFY1eUhsL3MwRUFu?=
 =?utf-8?B?cy9rNVFWZ0lNS29pUjBMUU15QlhNK21vQ1lkVlJIcDFHbko0dlZXWW04N1hL?=
 =?utf-8?B?YlozbHNhb00xMWdxYTYwdTRNRW42Mzg0c0JMc1F3TUVZQVR5WmdRbXhvb0M5?=
 =?utf-8?B?d3VJSEpJbmcwSUFHYzROOXV0aFVlZkN2bklPdGlxa0pvUi9tR3BPMklXeGFK?=
 =?utf-8?Q?AiYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1558.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b92d6-ed50-4306-edb8-08dd34589590
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 05:02:02.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNozBxLA9n4f+TaJqXyB4cO/HVigIvOTjDiLIjOl7DLMbfwkCTKNpoA9PP853GIWhmtT2UDp0DbDtQPQunTTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2022

RnJvbSAyM2JiYjVhMmVjZTgwN2I5M2VkZjM3ODYzNjI0MTMzZTIwYjUxMWQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiaG9uZ3Npay5qbyIgPGhvbmdzaWsuam9AbGdlLmNvbT4KRGF0
ZTogVGh1LCA5IEphbiAyMDI1IDEzOjQxOjE4ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gQXZvaWQg
c3ltYm9sIGNvbGxpc2lvbiBiZXR3ZWVuIHVsb2dkIGFuZCBqYW5zc29uLgoKaGFzdGFibGVfZGVs
KCkgaXMgYm90aCBleGlzdGVkIGluIHVsb2dkIGFuZCBqYW5zc29uLgpBbmQgaXQgY2FuIGNhdXNl
cyBzeW1ib2wgY29sbGlzaW9uLCB0cnkgdG8gYXZvaWQgaXQuCgpTaWduZWQtb2ZmLWJ5OiBob25n
c2lrLmpvIDxob25nc2lrLmpvQGxnZS5jb20+Ci0tLQrCoGluY2x1ZGUvdWxvZ2QvaGFzaC5oIMKg
IMKgIMKgIMKgIMKgIMKgfCAyICstCsKgaW5wdXQvZmxvdy91bG9nZF9pbnBmbG93X05GQ1QuYyB8
IDQgKystLQrCoHNyYy9oYXNoLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDIg
Ky0KwqAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL3Vsb2dkL2hhc2guaCBiL2luY2x1ZGUvdWxvZ2QvaGFzaC5oCmlu
ZGV4IGQ0YWVkYjguLjRiNDg3NGIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWxvZ2QvaGFzaC5oCisr
KyBiL2luY2x1ZGUvdWxvZ2QvaGFzaC5oCkBAIC0zNCw3ICszNCw3IEBAIHZvaWQgaGFzaHRhYmxl
X2Rlc3Ryb3koc3RydWN0IGhhc2h0YWJsZSAqaCk7CsKgaW50IGhhc2h0YWJsZV9oYXNoKGNvbnN0
IHN0cnVjdCBoYXNodGFibGUgKnRhYmxlLCBjb25zdCB2b2lkICpkYXRhKTsKwqBzdHJ1Y3QgaGFz
aHRhYmxlX25vZGUgKmhhc2h0YWJsZV9maW5kKGNvbnN0IHN0cnVjdCBoYXNodGFibGUgKnRhYmxl
LCBjb25zdCB2b2lkICpkYXRhLCBpbnQgaWQpOwrCoGludCBoYXNodGFibGVfYWRkKHN0cnVjdCBo
YXNodGFibGUgKnRhYmxlLCBzdHJ1Y3QgaGFzaHRhYmxlX25vZGUgKm4sIGludCBpZCk7Ci12b2lk
IGhhc2h0YWJsZV9kZWwoc3RydWN0IGhhc2h0YWJsZSAqdGFibGUsIHN0cnVjdCBoYXNodGFibGVf
bm9kZSAqbm9kZSk7Cit2b2lkIGhhc2h0YWJsZV9kZWxldGUoc3RydWN0IGhhc2h0YWJsZSAqdGFi
bGUsIHN0cnVjdCBoYXNodGFibGVfbm9kZSAqbm9kZSk7CsKgaW50IGhhc2h0YWJsZV9mbHVzaChz
dHJ1Y3QgaGFzaHRhYmxlICp0YWJsZSk7CsKgaW50IGhhc2h0YWJsZV9pdGVyYXRlKHN0cnVjdCBo
YXNodGFibGUgKnRhYmxlLCB2b2lkICpkYXRhLArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpbnQgKCppdGVyYXRlKSh2b2lkICpkYXRhLCB2b2lkICpuKSk7CmRpZmYgLS1naXQgYS9p
bnB1dC9mbG93L3Vsb2dkX2lucGZsb3dfTkZDVC5jIGIvaW5wdXQvZmxvdy91bG9nZF9pbnBmbG93
X05GQ1QuYwppbmRleCA4OTliN2UzLi4zOGJhZjA1IDEwMDY0NAotLS0gYS9pbnB1dC9mbG93L3Vs
b2dkX2lucGZsb3dfTkZDVC5jCisrKyBiL2lucHV0L2Zsb3cvdWxvZ2RfaW5wZmxvd19ORkNULmMK
QEAgLTcwMiw3ICs3MDIsNyBAQCBldmVudF9oYW5kbGVyX2hhc2h0YWJsZShlbnVtIG5mX2Nvbm50
cmFja19tc2dfdHlwZSB0eXBlLArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAodHMpIHsKwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0X3RpbWVzdGFtcF9mcm9tX2N0KHRz
LCBjdCwgU1RPUCk7CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvX3Byb3Bh
Z2F0ZV9jdCh1cGksIGN0LCB0eXBlLCB0cyk7Ci0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaGFzaHRhYmxlX2RlbChjcGktPmN0X2FjdGl2ZSwgJnRzLT5oYXNobm9kZSk7CisgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGFzaHRhYmxlX2RlbGV0ZShjcGktPmN0X2Fj
dGl2ZSwgJnRzLT5oYXNobm9kZSk7CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IG5mY3RfZGVzdHJveSh0cy0+Y3QpOwrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBmcmVlKHRzKTsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHsKQEAgLTg4Niw3ICs4
ODYsNyBAQCBzdGF0aWMgaW50IGRvX3B1cmdlKHZvaWQgKmRhdGExLCB2b2lkICpkYXRhMikKwqAg
wqAgwqAgwqAgcmV0ID0gbmZjdF9xdWVyeShjcGktPnBnaCwgTkZDVF9RX0dFVCwgdHMtPmN0KTsK
wqAgwqAgwqAgwqAgaWYgKHJldCA9PSAtMSAmJiBlcnJubyA9PSBFTk9FTlQpIHsKwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZG9fcHJvcGFnYXRlX2N0KHVwaSwgdHMtPmN0LCBORkNUX1RfREVTVFJP
WSwgdHMpOwotIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGhhc2h0YWJsZV9kZWwoY3BpLT5jdF9hY3Rp
dmUsICZ0cy0+aGFzaG5vZGUpOworIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGhhc2h0YWJsZV9kZWxl
dGUoY3BpLT5jdF9hY3RpdmUsICZ0cy0+aGFzaG5vZGUpOwrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBuZmN0X2Rlc3Ryb3kodHMtPmN0KTsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJlZSh0cyk7
CsKgIMKgIMKgIMKgIH0KZGlmZiAtLWdpdCBhL3NyYy9oYXNoLmMgYi9zcmMvaGFzaC5jCmluZGV4
IDFkOTkxMzAuLjhmZDk4YTEgMTAwNjQ0Ci0tLSBhL3NyYy9oYXNoLmMKKysrIGIvc3JjL2hhc2gu
YwpAQCAtOTEsNyArOTEsNyBAQCBpbnQgaGFzaHRhYmxlX2FkZChzdHJ1Y3QgaGFzaHRhYmxlICp0
YWJsZSwgc3RydWN0IGhhc2h0YWJsZV9ub2RlICpuLCBpbnQgaWQpCsKgIMKgIMKgIMKgIHJldHVy
biAwOwrCoH0KCi12b2lkIGhhc2h0YWJsZV9kZWwoc3RydWN0IGhhc2h0YWJsZSAqdGFibGUsIHN0
cnVjdCBoYXNodGFibGVfbm9kZSAqbikKK3ZvaWQgaGFzaHRhYmxlX2RlbGV0ZShzdHJ1Y3QgaGFz
aHRhYmxlICp0YWJsZSwgc3RydWN0IGhhc2h0YWJsZV9ub2RlICpuKQrCoHsKwqAgwqAgwqAgwqAg
bGxpc3RfZGVsKCZuLT5oZWFkKTsKwqAgwqAgwqAgwqAgdGFibGUtPmNvdW50LS07Ci0tCjIuMzQu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrrs7Trgrgg7IKs656M
OsKg7KGw7ZmN7IudL+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuwnOyLpCBTVyBTZWN1
cml0eSBUUCA8aG9uZ3Npay5qb0BsZ2UuY29tPgrrs7Trgrgg64Kg7KecOsKgMjAyNeuFhCAx7JuU
IDE07J28IO2ZlOyalOydvCDsmKTtm4QgMjowMArrsJvripQg7IKs656MOsKgUGFibG8gTmVpcmEg
QXl1c28gPHBhYmxvQG5ldGZpbHRlci5vcmc+CuywuOyhsDrCoG5ldGZpbHRlci1kZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmcgPG5ldGZpbHRlci1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc+OyDshpDsmIHshK0v
7LGF7J6E7Jew6rWs7JuQL1NXIFNlY3VyaXR56rCc67Cc7IukIFNXIFNlY3VyaXR5IFRQIDxsb3Ro
LnNvbkBsZ2UuY29tPjsg64Ko7KCV7KO8L+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuw
nOyLpCBTVyBTZWN1cml0eSBUUCA8anVuZ2pvby5uYWhtQGxnZS5jb20+OyDsoJXsnqzsnKQvVGFz
ayBMZWFkZXIvU1cgUGxhdGZvcm0o7JewKeyEoO2WiVBsYXRmb3Jt6rCc67Cc7IukIOyLnOyKpO2F
nFNXIFRhc2sgPGphZXlvb24uanVuZ0BsZ2UuY29tPjsg7KGw7ZmN7IudL+yxheyehOyXsOq1rOyb
kC9TVyBTZWN1cml0eeqwnOuwnOyLpCBTVyBTZWN1cml0eSBUUCA8aG9uZ3Npay5qb0BsZ2UuY29t
PgrsoJzrqqk6wqBSZTogU3ltYm9sIENvbGxpc2lvbiBiZXR3ZWVuIHVsb2dkIGFuZCBqYW5zc29u
CsKgCkhlcmUgaXMgdGhlIHJlc3VsdCBvZiBmaW5kaW5nIHN5bWJvbHMgaW4gdWxvZ2QgYW5kIGxp
YmphbnNzb24uCgokIG5tIC1EIGxpYmphbnNzb24uc28gfCBncmVwIGhhc2h0YWJsZV9kZWwKMDAw
MDAwMDAwMDAwNWI1MCBUIGhhc2h0YWJsZV9kZWxAQEpBTlNTT05fNAoKJCBubSB1bG9nZCB8IGdy
ZXAgaGFzaHRhYmxlX2RlbAowMDAwMDAwMDAwMDA3NzA0IFQgaGFzaHRhYmxlX2RlbAoKV2UgZGlk
IG5vdCBidWlsZCBpdCBhcyBhIHN0YXRpYyBsaWJyYXJ5LgpMaWtlIHlvdSBtZW50aW9uZWQsIEkg
YWxzbyBkbyBub3Qga25vdyB0aGUgZXhhY3QgcmVhc29uIHdoeSBhIFNFR1Ygb2NjdXJzIGluIHRo
aXMgY2FzZS4KSG93ZXZlciwgSSBoYXZlIGNvbmZpcm1lZCB0aHJvdWdoIHNvdXJjZXMgbGlrZSBH
UFQgdGhhdCBzeW1ib2wgY29sbGlzaW9ucyBjYW4gb2NjdXIgaW4gc3VjaCBzaXR1YXRpb25zICh0
aGUgcG9zc2liaWxpdHkgb2Ygc3ltYm9sIGNvbGxpc2lvbnMgZHVlIHRvIHRoZSBsb2FkaW5nIG9y
ZGVyIG9mIGxpYnJhcmllcykuCgpBbnN3ZXJzIG9mIEdQVDoKVGhlcmVmb3JlLCBldmVuIGlmIGEg
c3ltYm9sIHZlcnNpb24gbGlrZSBoYXNodGFibGVfZGVsQEBKQU5TU09OXzQgZXhpc3RzLCBpZiBh
IHN5bWJvbCB3aXRoIHRoZSBzYW1lIG5hbWUgaXMgZGVmaW5lZCBpbiBhbm90aGVyIGxpYnJhcnks
IGEgc3ltYm9sIGNvbGxpc2lvbiBjYW4gc3RpbGwgb2NjdXIuCkluIHN1Y2ggY2FzZXMsIHdoaWNo
IHN5bWJvbCBnZXRzIGNhbGxlZCB3aWxsIGRlcGVuZCBvbiBmYWN0b3JzIHN1Y2ggYXMgbGlicmFy
eSBsb2FkIG9yZGVyLCB2ZXJzaW9uIGluZm9ybWF0aW9uLCBhbmQgZW52aXJvbm1lbnQgdmFyaWFi
bGUgc2V0dGluZ3MuCgpBbnl3YXksIEknbGwgdXBkYXRlIHRoZSBwYXRjaCAoaW5jbHVkaW5nIFNp
Z25lZC1vZmYtYnk6wqApIGluIG5leHQgcmVwbHkgdG8gZGl2aWRlIHRoZSBjb250ZW50LgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrrs7Trgrgg7IKs656MOsKgUGFi
bG8gTmVpcmEgQXl1c28gPHBhYmxvQG5ldGZpbHRlci5vcmc+CuuztOuCuCDrgqDsp5w6wqAyMDI1
64WEIDHsm5QgMTTsnbwg7ZmU7JqU7J28IOyYpOyghCA3OjIzCuuwm+uKlCDsgqzrnow6wqDsobDt
mY3si50v7LGF7J6E7Jew6rWs7JuQL1NXIFNlY3VyaXR56rCc67Cc7IukIFNXIFNlY3VyaXR5IFRQ
IDxob25nc2lrLmpvQGxnZS5jb20+CuywuOyhsDrCoG5ldGZpbHRlci1kZXZlbEB2Z2VyLmtlcm5l
bC5vcmcgPG5ldGZpbHRlci1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc+OyDshpDsmIHshK0v7LGF7J6E
7Jew6rWs7JuQL1NXIFNlY3VyaXR56rCc67Cc7IukIFNXIFNlY3VyaXR5IFRQIDxsb3RoLnNvbkBs
Z2UuY29tPjsg64Ko7KCV7KO8L+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqwnOuwnOyLpCBT
VyBTZWN1cml0eSBUUCA8anVuZ2pvby5uYWhtQGxnZS5jb20+OyDsoJXsnqzsnKQvVGFzayBMZWFk
ZXIvU1cgUGxhdGZvcm0o7JewKeyEoO2WiVBsYXRmb3Jt6rCc67Cc7IukIOyLnOyKpO2FnFNXIFRh
c2sgPGphZXlvb24uanVuZ0BsZ2UuY29tPgrsoJzrqqk6wqBSZTogU3ltYm9sIENvbGxpc2lvbiBi
ZXR3ZWVuIHVsb2dkIGFuZCBqYW5zc29uCsKgCkhpLAoKT24gTW9uLCBKYW4gMTMsIDIwMjUgYXQg
MDY6NDE6MTlBTSArMDAwMCwg7KGw7ZmN7IudL+yxheyehOyXsOq1rOybkC9TVyBTZWN1cml0eeqw
nOuwnOyLpCBTVyBTZWN1cml0eSBUUCB3cm90ZToKPiBUaGUgaXNzdWUgSSB3b3VsZCBsaWtlIHRv
IGJyaW5nIHRvIHlvdXIgYXR0ZW50aW9uIGlzIGFzIGZvbGxvd3M6IFdlCj4gYXJlIHVzaW5nIHRo
ZSBKU09OIGZlYXR1cmUgaW4gdGhlIFBBQ0tBR0VDT05GSUcgb2YgdWxvZ2QsIGFuZCB3ZQo+IGhh
dmUgZGlzY292ZXJlZCB0aGF0IGJvdGggdWxvZ2QgYW5kIGphbnNzb24gaGF2ZSBtZXRob2RzIHdp
dGggdGhlCj4gc2FtZSBuYW1lLCB3aGljaCBjYW4gbGVhZCB0byBhIHN5bWJvbCByZWZlcmVuY2Ug
ZXJyb3IgcmVzdWx0aW5nIGluIGEKPiBzZWdtZW50YXRpb24gZmF1bHQuwqAgVGhlIG1ldGhvZCBp
biBxdWVzdGlvbiBpcyBoYXNodGFibGVfZGVsKCkuCj4gQmFzZWQgb24gb3VyIGJhY2t0cmFjZSBh
bmFseXNpcywgaXQgYXBwZWFycyB0aGF0IHdoZW4gdWxvZ2Qncwo+IGhhc2h0YWJsZV9kZWwoKSBp
cyBleGVjdXRlZCBpbnN0ZWFkIG9mIGphbnNzb24ncyBoYXNodGFibGVfZGVsKCksIGl0Cj4gbGVh
ZHMgdG8gYSBzZWdtZW50YXRpb24gZmF1bHQgKFNFR1YpLgo+IFRvIGF2b2lkIHRoaXMgc3ltYm9s
IGNvbGxpc2lvbiwgSSBtb2RpZmllZCB1bG9nZCdzIGhhc2h0YWJsZV9kZWwoKQo+IHRvIGhhc2h0
YWJsZV9kZWxldGUoKSwgYW5kIEkgaGF2ZSBjb25maXJtZWQgdGhhdCB0aGlzIHJlc29sdmVzIHRo
ZQo+IGlzc3VlLgoKJCBubSAtRCBsaWJqYW5zc29uLnNvLjQgfCBncmVwIGhhc2h0YWJsZV9kZWwK
JAoKQXJlIHlvdSBidWlsZGluZyBhIHN0YXRpYyBiaW5hcnk/IE90aGVyd2lzZSwgSSBkb24ndCBz
ZWUgaG93IHRoZSBjbGFzaAppcyBnb2luZyBvbi4KCkkgYW0gZmluZSB3aXRoIHRoaXMgcGF0Y2gs
IHdvdWxkIHlvdSBzdWJtaXQgaXQgdXNpbmcgZ2l0IGZvcm1hdC1wYXRjaAphbmQgaW5jbHVkaW5n
IFNpZ25lZC1vZmYtYnk6PwoKVGhhbmtzLg==

