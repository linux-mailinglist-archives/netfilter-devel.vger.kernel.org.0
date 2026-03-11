Return-Path: <netfilter-devel+bounces-11113-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OnfGlXHsGnTmwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11113-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 02:37:25 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC925A654
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 02:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB4F3059AF4
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68136E480;
	Wed, 11 Mar 2026 01:37:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from cstnet.cn (smtp86.cstnet.cn [159.226.251.86])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406D36C9E0
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193038; cv=none; b=hmFd/HSBoT/9N8eciwDX0Bli6Yu4H6qngP/EK3EHV+Ws+RXSTyeix0okLzDlhVQzrK64qizaqS08eIJ3s49+YviKBcATqjoLpqhzd4aT3HYK6V/AbdBByiVuC6YB1CEeehYvIrTEW2Y4SFJ0XL0VDaq8LspZDdKwgN1cVE62pYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193038; c=relaxed/simple;
	bh=nVN9//BVPp2AQPDfpW8RT0QQJv46BTtAhN57RtEhSHw=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=jslAxJ2nTCrayVWlyzeCmgkTvl9RAq0Swqdgd/YaXzSQJvK/foRlRYSwb9gxadOFigVtIjuxfnJY1DRlzXhB8UP6xINQRes3W0ZxqL603Wo4jNFha5XbCxotdoXdcAE9DmRJBpLiMDswBBV231FtK7EcqeeW+B4hHQvvYtel9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from pengpeng$iscas.ac.cn ( [23.249.16.216] ) by
 ajax-webmail-APP-16 (Coremail) ; Wed, 11 Mar 2026 09:37:13 +0800
 (GMT+08:00)
Date: Wed, 11 Mar 2026 09:37:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L6v5pyL5pyL?= <pengpeng@iscas.ac.cn>
To: netfilter-devel@vger.kernel.org
Subject: [BUG] libnftnl: missing length validation in Geneve tunnel option
 handling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7a6e072d.57068.19cda8a76e5.Coremail.pengpeng@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:sQCowADHrLBKx7BpFR4WAA--.49715W
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/1tbiCREDBWmwubglDwACsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: DEAC925A654
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11113-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_X_PRIO_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

SGkgbmV0ZmlsdGVyIGRldmVsb3BlcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IHR3byBsZW5n
dGgtdmFsaWRhdGlvbiBpc3N1ZXMgaW4gbGlibmZ0bmwsIGJvdGggaW4gdGhlIEdlbmV2ZSB0dW5u
ZWwgb3B0aW9uIGhhbmRsaW5nIGluIHNyYy9vYmovdHVubmVsLmMuClRoZXNlIGFwcGVhciB0byBi
ZSBtZW1vcnktc2FmZXR5IGJ1Z3MgY2F1c2VkIGJ5IG1pc3NpbmcgYm91bmRzIGNoZWNrcyBpbiBm
aXhlZC1zaXplIGRlc3RpbmF0aW9ucy4KCiMjIElzc3VlIDE6IG1pc3NpbmcgbGVuZ3RoIHZhbGlk
YXRpb24gaW4gcHVibGljIHNldHRlcgoKRnVuY3Rpb246Cm5mdG5sX3R1bm5lbF9vcHRfZ2VuZXZl
X3NldCgpCgpQcm9ibGVtOgpGb3IgTkZUTkxfVFVOTkVMX0dFTkVWRV9DTEFTUyBhbmQgTkZUTkxf
VFVOTkVMX0dFTkVWRV9UWVBFLApkYXRhX2xlbiBpcyB1c2VkIGRpcmVjdGx5IGluIG1lbWNweSgp
IHdpdGhvdXQgdmFsaWRhdGluZyB0aGF0IGl0IG1hdGNoZXMKdGhlIGRlc3RpbmF0aW9uIGZpZWxk
IHNpemUuCgpSZWxldmFudCBjb2RlIHBhdHRlcm46CgpjYXNlIE5GVE5MX1RVTk5FTF9HRU5FVkVf
Q0xBU1M6Cm1lbWNweSgmb3B0LT5nZW5ldmUuZ2VuZXZlX2NsYXNzLCBkYXRhLCBkYXRhX2xlbik7
CmJyZWFrOwpjYXNlIE5GVE5MX1RVTk5FTF9HRU5FVkVfVFlQRToKbWVtY3B5KCZvcHQtPmdlbmV2
ZS50eXBlLCBkYXRhLCBkYXRhX2xlbik7CmJyZWFrOwoKVGhlIGRlc3RpbmF0aW9uIGZpZWxkcyBh
cmUgZml4ZWQtc2l6ZToKZ2VuZXZlX2NsYXNzOiAyIGJ5dGVzCnR5cGU6IDEgYnl0ZQoKU28gYSBj
YWxsZXIgY2FuIHBhc3MgYSBsYXJnZXIgZGF0YV9sZW4gYW5kIG92ZXJ3cml0ZSBzdWJzZXF1ZW50
IGZpZWxkcwppbnNpZGUgdGhlIEdlbmV2ZSBzdWItc3RydWN0dXJlLgoKCiMjIElzc3VlIDI6IG1p
c3NpbmcgdXBwZXItYm91bmQgY2hlY2sgaW4gTmV0bGluayBwYXJzaW5nIHBhdGgKCkZ1bmN0aW9u
OgpuZnRubF9vYmpfdHVubmVsX3BhcnNlX2dlbmV2ZSgpCgpQcm9ibGVtOgpUaGUgcGFyc2VyIGNv
cGllcyB0aGUgTkZUQV9UVU5ORUxfS0VZX0dFTkVWRV9EQVRBIHBheWxvYWQgaW50byBhIGZpeGVk
CjEyNy1ieXRlIGJ1ZmZlciB3aXRob3V0IGNoZWNraW5nIHdoZXRoZXIgdGhlIHBheWxvYWQgbGVu
Z3RoIGV4Y2VlZHMgdGhlCmRlc3RpbmF0aW9uIGNhcGFjaXR5LgoKUmVsZXZhbnQgY29kZSBwYXR0
ZXJuOgoKaWYgKHRiW05GVEFfVFVOTkVMX0tFWV9HRU5FVkVfREFUQV0pIHsKdWludDMyX3QgbGVu
ID0gbW5sX2F0dHJfZ2V0X3BheWxvYWRfbGVuKHRiW05GVEFfVFVOTkVMX0tFWV9HRU5FVkVfREFU
QV0pOwptZW1jcHkob3B0LT5nZW5ldmUuZGF0YSwKbW5sX2F0dHJfZ2V0X3BheWxvYWQodGJbTkZU
QV9UVU5ORUxfS0VZX0dFTkVWRV9EQVRBXSksCmxlbik7Cm9wdC0+Z2VuZXZlLmRhdGFfbGVuID0g
bGVuOwp9CgpUaGUgZGVzdGluYXRpb24gYnVmZmVyIGlzOgpvcHQtPmdlbmV2ZS5kYXRhWzEyN10K
CklmIGxlbiA+IDEyNywgdGhpcyBvdmVyd3JpdGVzIHRoZSBmb2xsb3dpbmcgZmllbGQocykgYW5k
IG1heSBjb3JydXB0CmFkamFjZW50IG1lbW9yeS4KCgojIyBTdWdnZXN0ZWQgZml4ZXMKCjEuIElu
IG5mdG5sX3R1bm5lbF9vcHRfZ2VuZXZlX3NldCgpOgoKICAgKiByZXF1aXJlIGRhdGFfbGVuID09
IHNpemVvZih1aW50MTZfdCkgZm9yIE5GVE5MX1RVTk5FTF9HRU5FVkVfQ0xBU1MKICAgKiByZXF1
aXJlIGRhdGFfbGVuID09IHNpemVvZih1aW50OF90KSBmb3IgTkZUTkxfVFVOTkVMX0dFTkVWRV9U
WVBFCgoKMi4gSW4gbmZ0bmxfb2JqX3R1bm5lbF9wYXJzZV9nZW5ldmUoKToKCiAgICogcmVqZWN0
IHBheWxvYWRzIHdoZXJlIGxlbiA+IE5GVE5MX1RVTk5FTF9HRU5FVkVfREFUQV9NQVhMRU4KCgpG
b3IgZXhhbXBsZToKaWYgKGxlbiA+IE5GVE5MX1RVTk5FTF9HRU5FVkVfREFUQV9NQVhMRU4pCnJl
dHVybiAtMTsKCgpCZXN0IHJlZ2FyZHMsClBlbmdwZW5nIEhvdQpwZW5ncGVuZ0Bpc2Nhcy5hYy5j
biAK

