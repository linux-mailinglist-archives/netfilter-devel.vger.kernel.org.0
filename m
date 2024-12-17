Return-Path: <netfilter-devel+bounces-5543-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE29F58BF
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2024 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3837189686C
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135011F9F75;
	Tue, 17 Dec 2024 21:21:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0B1F9ECD
	for <netfilter-devel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470465; cv=none; b=aRg8BCsP7JIPV4Zd5gg7SfWYxDnZLCkoqxkAB8tBFNGJBcyy+64qWUTpyrbwjSdRLoeItr/nwrAtrKOv8PNVo4sTnbJO1NxDwLY0h6wz5quUOxDm5awxWGhzZvHbZc7R704hx3Z1ugPwdqHhNYoCZ/PBrEeU0iwn648wRfNoOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470465; c=relaxed/simple;
	bh=f+kAFma0JdvdUREsF+uOaXxJl8HKI69w+Df0iJcegBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFLJPFP6p8HisOgvj++x+3gldZZSai9K86/ZF9B1Zzs+muS7SIsM84/VF02TfytscLuSuRToq27nTrnjGRpssUN0G6J5M9G6AwIeUW9kHWecwtrScZyXhgo60dmx/fm6SDXa/GZvtPMu0LaSVFDFVW5mgse1ODUNhmnmSgCnM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 4/6] rule: constify set_is_non_concat_range()
Date: Tue, 17 Dec 2024 22:15:14 +0100
Message-Id: <20241217211516.1644623-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241217211516.1644623-1-pablo@netfilter.org>
References: <20241217211516.1644623-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is read-only, constify it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/rule.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rule.h b/include/rule.h
index 238be23eca90..86477c709544 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -423,7 +423,7 @@ static inline bool set_is_interval(uint32_t set_flags)
 	return set_flags & NFT_SET_INTERVAL;
 }
 
-static inline bool set_is_non_concat_range(struct set *s)
+static inline bool set_is_non_concat_range(const struct set *s)
 {
 	return (s->flags & NFT_SET_INTERVAL) && s->desc.field_count <= 1;
 }
-- 
2.30.2


