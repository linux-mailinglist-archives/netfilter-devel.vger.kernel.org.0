Return-Path: <netfilter-devel+bounces-10545-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J6TBNEEafmnTVgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10545-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 16:05:37 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC84C29E8
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E42300A62F
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB362DB797;
	Sat, 31 Jan 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="X/Cyk9Zc";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="DgLo2nsb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from cvsmtppost103.wmail.worksmobile.com (cvsmtppost103.wmail.worksmobile.com [125.209.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2676026
	for <netfilter-devel@vger.kernel.org>; Sat, 31 Jan 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871933; cv=none; b=X5Dtt2iEGMC4Ch0whhLm9LCNcVsRxuT05wCHpU+Bq1+o+EBYbiisvqhQcKu6A+umK0cdsvEt9W4bh9uk0g5pmP54s968GYBnGsGE3dueLbZCmcbvbGddPYqEYZNKLBZVkhufYpL315n0ikCAd1NwEGU/xv9R7rdLJaZg5d8TmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871933; c=relaxed/simple;
	bh=0rCRLFKmhrHPhARXFL3Ypf3EWYIODC13M5nyEMjRRMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8Y4K+9HWR8ZFaSG9YcA/aOrjZC8TJU+eNBRQgyNg5z8CN3bKT7e2gBY3W2A41wJpnB6oFHbuzsQrIOvb7UFiW/dU0xwK9neJ/Kf+NfssFrERwMYqNNrX9vH9wOLwfYaUvm4k35FVYPXxycAmR7EzSWtWPHEPAHxFP9uDYCMzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=X/Cyk9Zc; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=DgLo2nsb; arc=none smtp.client-ip=125.209.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769871319;
	bh=0rCRLFKmhrHPhARXFL3Ypf3EWYIODC13M5nyEMjRRMY=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=X/Cyk9ZcZtvbcq0bVCCcY5R2G0aZX1Js7vGwblYWJELANUcD1z5qBDfxWArd0Qyh5
	 gHaEl0Ir7IZrsuzo3cvRsa7xahFsPtc9sNYDAClkG+pfk/wpsjmqjpbhqwp9tBlGC0
	 1vGklGTQXIcQtev3tsoLmDxqmWE4igp3VsTbGTqcGPKUzExP5zGBxxHW25Uv4bEgQn
	 SEu0iHG1G+o8ubDE4SSEXHV0FzvlGSx7RNvhO+SIVKz7ADNuqyS092RBUEnxIVYwiH
	 JW8a+pT0dHkVZr5LENXEnU8GIMEvqyhF4zt3UWOhjuVXJSqmMufS04AXxFgW0o8TbN
	 qgrATj2iwlmJg==
Received: from cvsendbo002.wmail ([10.113.20.164])
  by cvsmtppost103.wmail.worksmobile.com with ESMTP id VQrDR3CaSRG4mGuzlHkZSA
  for <netfilter-devel@vger.kernel.org>;
  Sat, 31 Jan 2026 14:55:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769871319;
	bh=0rCRLFKmhrHPhARXFL3Ypf3EWYIODC13M5nyEMjRRMY=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=DgLo2nsbGksmT/QNrK3XcT3KW8CMbssXZECJLK/QZT7VgpDXhqewTFrG1bYIPBvi0
	 0bzJ0ktGzAxlQyaTlfoH1ZsNfZ1jZB8UvFWIHI0vWNBUqUMgiOFhFmK19R3Mq5bf3h
	 ZfVdqHOJky+z19PwCQEAK2S1SRP6o3wLKtpOe+rU=
X-Session-ID: DED9fwbJSlmBNhX4BXeizA
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: V9nqaAvrFqJZ+Hm/Kxv/+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp401.gwmail.worksmobile.com with ESMTP id DED9fwbJSlmBNhX4BXeizA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 14:55:18 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in xt_register_matches/targets()?
Date: Sat, 31 Jan 2026 23:55:16 +0900
Message-Id: <20260131145516.3289625-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10545-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EC84C29E8
X-Rspamd-Action: no action

Hi,

I noticed that in net/netfilter/x_tables.c, the functions
xt_register_match() and xt_register_target() always return 0.

Both functions simply perform:
  - mutex_lock()
  - list_add()
  - mutex_unlock()
  - return 0

However, xt_register_matches() and xt_register_targets() check
the return values and have error handling paths:

  for (i = 0; i < n; i++) {
      err = xt_register_match(&match[i]);
      if (err)
          goto err;
  }

Since xt_register_match/target() never fail, these error checks
appear to be dead code.

I found multiple callers that check these return values:
  - net/netfilter/xt_set.c
  - net/netfilter/xt_MASQUERADE.c
  - and others

Is this intentional defensive coding for potential future changes,
or could this be cleaned up by making xt_register_match/target()
return void?

Thanks,
Ingyu Jang

