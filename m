Return-Path: <netfilter-devel+bounces-11155-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EfhJWHVsmlDQAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11155-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 16:01:53 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B0273DB3
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69AC302D1B1
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC873630A3;
	Thu, 12 Mar 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyxbqOIU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C84338939
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327591; cv=none; b=RErQP4bB2eiq4HvFhWNMfW8thwPRwc0b+FvRsc0+dTKL6FZOx9qX7/wyqW0KY1zuaLf7MpeYfaylVP9/57o9kzCilC85IYosreoVjVC7E67B+Sa12unRfkIoxz4P+sEPyCidjV5hWRA+ioxgMd/EFkNlSyCQx742eN4AGuB04rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327591; c=relaxed/simple;
	bh=SjMnlsQ4WY/OQE8sqVrRyjEu66h5gjDpFhRj3w+I4zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bIbG3m1MlWWO7kzay70/qSj/RKd3cx4UpWZLDNMOlsp/CNi78DWGX6bjdq8o37zeHRkVixFmkMo0BOWu6vmYYdRA/VsboU2ISGkrWXzLktcdR9dW5rjxRejZ8wYRMZ5/Ygq7p/Ce2V2uCMzFusnYgWQFumNYHe0vFjSAmlsKRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyxbqOIU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5090c48de85so13059011cf.0
        for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773327590; x=1773932390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4PJmVA5k7DDH3p9uARHgT86oQdHv/y0cojTHNDjevg=;
        b=VyxbqOIUNNpsAeK+w05ipNHY2ATOLwQFG6ARjfLJwFJHsBmCsWwL49ECSyQvFx59bJ
         TbvCyhYsTVGDCeejatEiceGV/WFks1RaL///AkNsXmt/8uHNqMel4szYZUo4nBKVKs/s
         OdF6mp/qwYukaZrds3WvifD6EPcxfsbGOc28jf9wtPmDzWz4+GQptPoBaGifgpdFU4Pq
         Ms1xlV8dA/hVErlVgNFMzBmT/7eqi7JdVClLFpUaoS0Rn2RkShs2z8wISy8MxjKB8fXp
         ajrRP3VoPS2HorggD2F8Tty8Uk2fZTPH9cK2H9um9Vv5SLXBGXmQDoK3gGML59dfouNT
         JNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327590; x=1773932390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4PJmVA5k7DDH3p9uARHgT86oQdHv/y0cojTHNDjevg=;
        b=qgU/uWqQbMExhzeDor2pQevXLZYyKe3COVCnUQ/PRyjpCnzORnz1w6biuZUj2VOGM2
         nRT9d5wLvkz8YzCFmZWyGxAfd8+SMQRJCelz8lX++SMWaRzs7kpPTGEue8VoWVXztW1J
         +BbA3zqSuegIxwnmGspz2suEyIVsW/Z/3X3KBYDQt11nQ01EjIgQgtpt2vpV5Lu8zb0j
         dR6ohHZe7tF/QVvvKh+4bwP/qKkYyf2jSmzRvy8z2Vpj49iRLufRvHG9bq2Qc1PbIuQ8
         XB20FRVAXym9Fnl2WgJJ/l1YQ6FBSeELrg+99To6Mo/d+1ZIujYYh2qzxTzWhkVwUaNc
         Gj7A==
X-Gm-Message-State: AOJu0YzLvpq7iRT5atGPK6jGj7HKiWuG6Zjx9IVU4b1GINqV9bazZZQ8
	Ng6SoVDiZo/XZjtPpOwKt4J9VH9oD2BgPJ+cGqLkK3p1OZGKUZImcXsJ
X-Gm-Gg: ATEYQzxXwfBOaaWQv+mQedy0wY6JmeZEizSBYQnRe6+q8rYTPijUXYKxfXPJDIkNhBx
	TFQzkZkTAejp0WSno2pxwXjlNzio+ZcyGRI3LpjJ/6zwoX5Rwip/GIzaQ3Z9Uu+U3ByojcW7cJ8
	/cAVkqJn2XmDPBbC931E4Aed0Z5XZhSHOMiKokh4BIYmKepNyx9XI4fbFUHKkS45vKXLpyCCqXV
	NJSxQ+V+Auc/qGUQUVEGahMq8fgl98evGVeXw958Ql9kEOgGLD4Nv5YmGUESbI3hKKw/KXgfxkE
	6hPNytca49q/0kSGexMj1lpIYLl7vMQBPsnh69wF45p/rGxzWvYHKN20Hb/qZ0lZnIew5q0fPa0
	9kVzQML6gkf4q8fxb73lSmrLD6FfNLL2pdIC+bKDmk9ltrLBmU8GcqwlPyvq8x1MGYTa1r4r7D4
	YW3k8lybCthryOr35DwLz2nfVvig0L3tTy2Q==
X-Received: by 2002:ac8:5ac6:0:b0:509:1cf9:ea18 with SMTP id d75a77b69052e-5093a22791amr87790611cf.73.1773327589797;
        Thu, 12 Mar 2026 07:59:49 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0e9658sm40388531cf.21.2026.03.12.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:59:49 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	fw@strlen.de,
	klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH] netfilter: xt_time: use unsigned int for monthday bit shift
Date: Thu, 12 Mar 2026 14:59:49 +0000
Message-Id: <20260312145949.3400275-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,vidocsecurity.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-11155-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qguanni@gmail.com,netfilter-devel@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[dawid.vidocsecurity.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 864B0273DB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The monthday field can be up to 31, and shifting a signed integer 1
by 31 positions (1 << 31) is undefined behavior in C, as the result
overflows a 32-bit signed int. Use 1U to ensure well-defined behavior
for all valid monthday values.

Change the weekday shift to 1U as well for consistency.

Fixes: ee4411a1b1e0 ("[NETFILTER]: x_tables: add xt_time match")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczadło <dawid@vidocsecurity.com>
Tested-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 net/netfilter/xt_time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 6aa12d0f54e2..61de85e02a40 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -227,13 +227,13 @@ time_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 	localtime_2(&current_time, stamp);
 
-	if (!(info->weekdays_match & (1 << current_time.weekday)))
+	if (!(info->weekdays_match & (1U << current_time.weekday)))
 		return false;
 
 	/* Do not spend time computing monthday if all days match anyway */
 	if (info->monthdays_match != XT_TIME_ALL_MONTHDAYS) {
 		localtime_3(&current_time, stamp);
-		if (!(info->monthdays_match & (1 << current_time.monthday)))
+		if (!(info->monthdays_match & (1U << current_time.monthday)))
 			return false;
 	}
 
-- 
2.34.1


