Return-Path: <netfilter-devel+bounces-12261-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKxaMVTe8Gn3aQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12261-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 18:20:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9210488BA0
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB0E430AEC7E
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8103B27F3;
	Tue, 28 Apr 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="sRPHGJxT"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CB31B830
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389567; cv=none; b=TVTkIt4/KTH9Jzs4qid3suD9Ri9iNUyiaBUJ2UR/ZRDMukfFuXP0xgCsZbUOIBUL1tTll4P4KPfZAfU2aCRLRBxxmZb697TwVzbf5FFyn6JP+c4/MvyCBKrz1Vc6MjVWjbY8zXwbWvaL7rVo7lzH9KFlsySA57pQo+kbRhneYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389567; c=relaxed/simple;
	bh=lWcRySZs9B81ott/+yTC7IJ4zMdKd9aQaZBCUB5BvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrjkio+UsWM8gaxMv1/KhniJCOMEW6HbynJYmd4C13GI4BI5tH//AzM/yJZK1Bq+ORiC2NipZna/btjAH11ITfcMgQiTtDzWeIUzGyR1zrBeQcucx2EOUVsL9zS3qdmC4gSw1+WnYlwXjCHFk7nHgfU/6NrlHKy6zNNZ1XSvxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=sRPHGJxT; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4g4kcM4HY1z7s856;
	Tue, 28 Apr 2026 17:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1777389553;
	 x=1779203954; bh=QjDmJMjlxJSIZ7Akj62zJfcnEb4+nJqpUBCzcEngXx4=; b=
	sRPHGJxTvesQlbRExAGnrwVo5TV5oWErn7OUrBdPtWMRFdOkY4JDxIRZ6SAQH1XT
	0oycFUS0SuGmLBFgSnYmnQ+ws2xvkf4y66aOX52vSgk5xPsyZlz7KG8mPiNEkGp3
	qgRQx5POyEf5Wrvlgcqwy1v8V1hPgRyNNxOIheT+vsY=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 9Tya1Abka0rJ; Tue, 28 Apr 2026 17:19:13 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp2.kfki.hu (Postfix) with ESMTPSA id 4g4kcK4Tntz7s855;
	Tue, 28 Apr 2026 17:19:13 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 7719C140E20; Tue, 28 Apr 2026 17:19:13 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/5] netfilter: ipset fixes
Date: Tue, 28 Apr 2026 17:19:08 +0200
Message-Id: <20260428151913.584739-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B9210488BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12261-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:mid];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Pablo,

Here follows the next version of tentative fixes for the current=20
list of ipset related issues: the previous one was against a wrong
tree and sashiko could not test it. I'll take into account sashiko=20
reports and after that submit the final versions. Thanks!

Best regards,
Jozsef

Jozsef Kadlecsik (5):
  netfilter: ipset: Fix data race between add and list header in all
    hash types
  netfilter: ipset: Fix data race between add and dump in all hash types
  netfilter: ipset: annotate "pos" for concurrent readers/writers
  netfilter: ipset: skip gc when resize is in progress
  netfilter: ipset: fix order of usage counters

 net/netfilter/ipset/ip_set_core.c     |  4 +-
 net/netfilter/ipset/ip_set_hash_gen.h | 67 ++++++++++++++++++---------
 2 files changed, 47 insertions(+), 24 deletions(-)

--=20
2.39.5


