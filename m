Return-Path: <netfilter-devel+bounces-8763-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97207B529B2
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Sep 2025 09:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A44A02102
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Sep 2025 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977182459C9;
	Thu, 11 Sep 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkvtB8YH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4FA329F3C;
	Thu, 11 Sep 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575006; cv=none; b=K7mV010ZBe+iTIX/jYy7gy00h8ileWNdM+eSYR2guSLhWy/TpjegMBQHWFpE12pj68FyWbn0zPpjYWsaAVBw7zjDGratGT2d9VOUdjumE5xUJrBqbU13wO0r3cSmEKWgmpeqGwmkpdsCnPEaBNsgLEGWwWY5ooO9f9p9/yaRdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575006; c=relaxed/simple;
	bh=7uGHdwspov13fWrmLMIbLwiUfvKN6M+pTzZVb9Q53Ro=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HlK7ZlCnf27TzAKMNJulVAe3qC9bDqkllpHSbisZEoyWwctTZFSPmsFo9J70OTbZSCYWjkdPuIgQBKfRZQ30AQJAOAxuXXM/CYLEWVjGmiYspalKx7n/1xqmL+ePBC4CjFeATa/pqve8LP04kmTBIZXi8mCoewwt2Mx8L/eB5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkvtB8YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0191C4CEF1;
	Thu, 11 Sep 2025 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757575006;
	bh=7uGHdwspov13fWrmLMIbLwiUfvKN6M+pTzZVb9Q53Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tkvtB8YHTF7I7A0YRsL6MPNezG5SFV6ujDtgOzwDMhRZaNV0US5mDp+tzYD6V7Y7t
	 d73fBQ4ox3f91qX62whcs9a6tbo+/0h6gdcf2qjX97pTYO/NUxFjtiXFfI1iJiHlzU
	 S6+ygrec/xkPoP/l7gmFJxogiyNvt76ZJBm0gFvmtg4/+OA/npZCjUUBgF7WN3rVMn
	 JuGBW7aH0p/Pb+55XkXWti9R7OS4T4eC9leg5tdub3wDU4sbW3zFTtI7CH9NyLU4uH
	 r/wSkuPlt0NMlokqK3rGuxRdU+JdqyJy9Bp2GidwlpG+sFju0gjUEr9aU4GH+pxYAW
	 SAWk46v9gaSPg==
Content-Type: multipart/mixed; boundary="------------wAejUPd1aokr3amusa9Pbb4V"
Message-ID: <04fa441a-0171-4569-8764-1cfad39b8386@kernel.org>
Date: Thu, 11 Sep 2025 09:16:40 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 0/7] netfilter: updates for net: manual merge
Content-Language: en-GB, fr-BE
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250910190308.13356-1-fw@strlen.de>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250910190308.13356-1-fw@strlen.de>

This is a multi-part message in MIME format.
--------------wAejUPd1aokr3amusa9Pbb4V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 10/09/2025 21:03, Florian Westphal wrote:
> Hi,
> 
> The following patchset contains Netfilter fixes for *net*:
> 
> WARNING: This results in a conflict on net -> net-next merge.
> Merge resolution walkthrough is at the end of this cover letter, see
> MERGE WALKTHROUGH.

Thank you for these instructions, that was very clear!

Just in case other people need that, attached is the corresponding 3-way
patch, and the rr-cache for this conflict is available there:

https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/580515b

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------wAejUPd1aokr3amusa9Pbb4V
Content-Type: text/x-patch; charset=UTF-8;
 name="4cab275179a48c3ded528b85c4daed7808a6f04c.patch"
Content-Disposition: attachment;
 filename="4cab275179a48c3ded528b85c4daed7808a6f04c.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYwppbmRleCA0YjY0YzNi
ZDhlNzAsNzkzNzkwZDc5ZDEzLi5hN2I4ZmE4Y2FiN2MKLS0tIGEvbmV0L25ldGZpbHRlci9u
ZnRfc2V0X3BpcGFwby5jCisrKyBiL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYwpA
QEAgLTU2Miw3IC01MzksNyArNTc4LDcgQEBAIG5mdF9waXBhcG9fbG9va3VwKGNvbnN0IHN0
cnVjdCBuZXQgKm5ldAogIAljb25zdCBzdHJ1Y3QgbmZ0X3BpcGFwb19lbGVtICplOwogIAog
IAltID0gcmN1X2RlcmVmZXJlbmNlKHByaXYtPm1hdGNoKTsKLSAJZSA9IHBpcGFwb19nZXRf
c2xvdyhtLCAoY29uc3QgdTggKilrZXksIGdlbm1hc2ssIGdldF9qaWZmaWVzXzY0KCkpOwog
LQllID0gcGlwYXBvX2dldChtLCAoY29uc3QgdTggKilrZXksIE5GVF9HRU5NQVNLX0FOWSwg
Z2V0X2ppZmZpZXNfNjQoKSk7CisrCWUgPSBwaXBhcG9fZ2V0X3Nsb3cobSwgKGNvbnN0IHU4
ICopa2V5LCBORlRfR0VOTUFTS19BTlksIGdldF9qaWZmaWVzXzY0KCkpOwogIAogIAlyZXR1
cm4gZSA/ICZlLT5leHQgOiBOVUxMOwogIH0KZGlmZiAtLWNjIG5ldC9uZXRmaWx0ZXIvbmZ0
X3NldF9waXBhcG9fYXZ4Mi5jCmluZGV4IDc1NTkzMDZkMGFlZCxjMDg4NGZhNjhjNzkuLjI3
ZGFiMzY2NzU0OAotLS0gYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvX2F2eDIuYwor
KysgYi9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvX2F2eDIuYwpAQEAgLTEyMjYsNzUg
LTEyNDEsMjggKzEyMjYsNzQgQEBAIG5leHRfbWF0Y2gKICAKICAjdW5kZWYgTkZUX1NFVF9Q
SVBBUE9fQVZYMl9MT09LVVAKICAKIC0JCWlmIChyZXQgPCAwKQogLQkJCWdvdG8gb3V0Owog
LQogLQkJaWYgKGxhc3QpIHsKIC0JCQljb25zdCBzdHJ1Y3QgbmZ0X3NldF9leHQgKmUgPSAm
Zi0+bXRbcmV0XS5lLT5leHQ7CiAtCiAtCQkJaWYgKHVubGlrZWx5KG5mdF9zZXRfZWxlbV9l
eHBpcmVkKGUpKSkKIC0JCQkJZ290byBuZXh0X21hdGNoOwogLQogLQkJCWV4dCA9IGU7CiAt
CQkJZ290byBvdXQ7CiArCQlpZiAocmV0IDwgMCkgewogKwkJCXNjcmF0Y2gtPm1hcF9pbmRl
eCA9IG1hcF9pbmRleDsKICsJCQlrZXJuZWxfZnB1X2VuZCgpOwogKwkJCV9fbG9jYWxfdW5s
b2NrX25lc3RlZF9iaCgmc2NyYXRjaC0+YmhfbG9jayk7CiArCQkJcmV0dXJuIE5VTEw7CiAg
CQl9CiAgCiArCQlpZiAobGFzdCkgewogKwkJCXN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKmU7
CiArCiArCQkJZSA9IGYtPm10W3JldF0uZTsKICsJCQlpZiAodW5saWtlbHkoX19uZnRfc2V0
X2VsZW1fZXhwaXJlZCgmZS0+ZXh0LCB0c3RhbXApIHx8CiArCQkJCSAgICAgIW5mdF9zZXRf
ZWxlbV9hY3RpdmUoJmUtPmV4dCwgZ2VubWFzaykpKQogKwkJCQlnb3RvIG5leHRfbWF0Y2g7
CiArCiArCQkJc2NyYXRjaC0+bWFwX2luZGV4ID0gbWFwX2luZGV4OwogKwkJCWtlcm5lbF9m
cHVfZW5kKCk7CiArCQkJX19sb2NhbF91bmxvY2tfbmVzdGVkX2JoKCZzY3JhdGNoLT5iaF9s
b2NrKTsKICsJCQlyZXR1cm4gZTsKICsJCX0KICsKICsJCW1hcF9pbmRleCA9ICFtYXBfaW5k
ZXg7CiAgCQlzd2FwKHJlcywgZmlsbCk7CiAtCQlycCArPSBORlRfUElQQVBPX0dST1VQU19Q
QURERURfU0laRShmKTsKICsJCWRhdGEgKz0gTkZUX1BJUEFQT19HUk9VUFNfUEFEREVEX1NJ
WkUoZik7CiAgCX0KICAKIC1vdXQ6CiAtCWlmIChpICUgMikKIC0JCXNjcmF0Y2gtPm1hcF9p
bmRleCA9ICFtYXBfaW5kZXg7CiAgCWtlcm5lbF9mcHVfZW5kKCk7CiArCV9fbG9jYWxfdW5s
b2NrX25lc3RlZF9iaCgmc2NyYXRjaC0+YmhfbG9jayk7CiArCXJldHVybiBOVUxMOwogK30K
ICsKICsvKioKICsgKiBuZnRfcGlwYXBvX2F2eDJfbG9va3VwKCkgLSBEYXRhcGxhbmUgZnJv
bnRlbmQgZm9yIEFWWDIgaW1wbGVtZW50YXRpb24KICsgKiBAbmV0OglOZXR3b3JrIG5hbWVz
cGFjZQogKyAqIEBzZXQ6CW5mdGFibGVzIEFQSSBzZXQgcmVwcmVzZW50YXRpb24KICsgKiBA
a2V5OgluZnRhYmxlcyBBUEkgZWxlbWVudCByZXByZXNlbnRhdGlvbiBjb250YWluaW5nIGtl
eSBkYXRhCiArICoKICsgKiBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBmcm9tIHRoZSBkYXRh
IHBhdGguICBJdCB3aWxsIHNlYXJjaCBmb3IKICsgKiBhbiBlbGVtZW50IG1hdGNoaW5nIHRo
ZSBnaXZlbiBrZXkgaW4gdGhlIGN1cnJlbnQgYWN0aXZlIGNvcHkgdXNpbmcKICsgKiB0aGUg
QVZYMiByb3V0aW5lcyBpZiB0aGUgRlBVIGlzIHVzYWJsZSBvciBmYWxsIGJhY2sgdG8gdGhl
IGdlbmVyaWMKICsgKiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgYWxnb3JpdGhtIG90aGVyd2lz
ZS4KICsgKgogKyAqIFJldHVybjogbmZ0YWJsZXMgQVBJIGV4dGVuc2lvbiBwb2ludGVyIG9y
IE5VTEwgaWYgbm8gbWF0Y2guCiArICovCiArY29uc3Qgc3RydWN0IG5mdF9zZXRfZXh0ICoK
ICtuZnRfcGlwYXBvX2F2eDJfbG9va3VwKGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwgY29uc3Qg
c3RydWN0IG5mdF9zZXQgKnNldCwKICsJCSAgICAgICBjb25zdCB1MzIgKmtleSkKICt7CiAr
CXN0cnVjdCBuZnRfcGlwYXBvICpwcml2ID0gbmZ0X3NldF9wcml2KHNldCk7Ci0gCXU4IGdl
bm1hc2sgPSBuZnRfZ2VubWFza19jdXIobmV0KTsKICsJY29uc3Qgc3RydWN0IG5mdF9waXBh
cG9fbWF0Y2ggKm07CiArCWNvbnN0IHU4ICpycCA9IChjb25zdCB1OCAqKWtleTsKICsJY29u
c3Qgc3RydWN0IG5mdF9waXBhcG9fZWxlbSAqZTsKICsKICsJbG9jYWxfYmhfZGlzYWJsZSgp
OwogKwogKwlpZiAodW5saWtlbHkoIWlycV9mcHVfdXNhYmxlKCkpKSB7CiArCQljb25zdCBz
dHJ1Y3QgbmZ0X3NldF9leHQgKmV4dDsKICsKICsJCWV4dCA9IG5mdF9waXBhcG9fbG9va3Vw
KG5ldCwgc2V0LCBrZXkpOwogKwogKwkJbG9jYWxfYmhfZW5hYmxlKCk7CiArCQlyZXR1cm4g
ZXh0OwogKwl9CiArCiArCW0gPSByY3VfZGVyZWZlcmVuY2UocHJpdi0+bWF0Y2gpOwogKwot
IAllID0gcGlwYXBvX2dldF9hdngyKG0sIHJwLCBnZW5tYXNrLCBnZXRfamlmZmllc182NCgp
KTsKKysJZSA9IHBpcGFwb19nZXRfYXZ4MihtLCBycCwgTkZUX0dFTk1BU0tfQU5ZLCBnZXRf
amlmZmllc182NCgpKTsKICAJbG9jYWxfYmhfZW5hYmxlKCk7CiAgCiAtCXJldHVybiBleHQ7
CiArCXJldHVybiBlID8gJmUtPmV4dCA6IE5VTEw7CiAgfQo=

--------------wAejUPd1aokr3amusa9Pbb4V--

