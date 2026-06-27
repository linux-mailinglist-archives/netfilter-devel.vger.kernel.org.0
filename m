Return-Path: <netfilter-devel+bounces-13491-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+PRBdevP2q0WwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13491-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 13:11:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76C6D1D09
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 13:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gxIJHJYg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13491-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13491-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F1E93015899
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF03590C3;
	Sat, 27 Jun 2026 11:11:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AE22097
	for <netfilter-devel@vger.kernel.org>; Sat, 27 Jun 2026 11:11:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782558674; cv=none; b=N4RHDCdExvuNMXNZ6pxk08SvkhkxjDYW2CbEydAQ06YeUHfrQr7KtqMYkoBDIi+hcBiWRnXeGcD3VvWN84dCDE9zH0XtLybbpafLj9BtZZZZlQMo1qNNmbYQNSYqcpKqpiTTxH/TG+5BS8i0gkqE1CmrU8zMrPd5gOo0/OnnQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782558674; c=relaxed/simple;
	bh=oxnTbTBDy4goRCR56tDJs7RGMyVWnbav+aiETb4LZdc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx2uZDjuN0BhifoXQt0eDbjsgDsn20oSTm+spSiOnS55nRDKYHVt24YbdLZz9fFGIszv530FBNklvgJOUQzUUBWStT1OqJze3Cife6OegZNT/WRhhq3+ithDK1c8NXHvtRSsDQ+2SoCBbuoWMm1p/xDeWkj3Def9FGpB7Sc8E6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxIJHJYg; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c965eab27so2132014eec.0
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Jun 2026 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782558672; x=1783163472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxnTbTBDy4goRCR56tDJs7RGMyVWnbav+aiETb4LZdc=;
        b=gxIJHJYg92mPGyeVRKaHb0f/7D0MWNTBDclNMY4f6CiakX4d8quLR3YRVPmOG+ObBz
         q78gKXh3LtPcjOTJJa2gzBb4YQMMPBauIZ1WgCDzB+XHWWFT0N/eHAKOSa0yWfqt2RSy
         HpGJTNS45XoMn1Ci5qbIpaW9kubpa/RMbb28dLzgOxWug45Gge5C+NKnzbuqR8fD3U23
         NobiCN0TBoCqXXboVfinW6dXoVRPhPpUrxSwOWrwcwcc30iIwR9ZW71bGGF7vu29bJ1f
         nXVj59EQJRLk2dkbVCLxF5uNy9LqsZia1uRw51NBLfFncn7j72/+Jk5YUBo81V3fUbku
         VA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782558672; x=1783163472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oxnTbTBDy4goRCR56tDJs7RGMyVWnbav+aiETb4LZdc=;
        b=V/kYES4m2JoeWInyfXc2slG/reHXIXafA0uS6T4lr0jkpDmGTtlL2yPx8achbGySiy
         MI2FdOstLOi1fUbTIqfxnik2/EKGMb11F+tU9ghncWR4cwHBj5/B0nka4+MwnnOzA6vI
         R9EcCuTzQ9omHQgGDjhRuOK+Z6NQtq10l2QGOpVUsgitd6zbMku5vajx61c1DNRXCSSS
         szE2toS8pQa7Lta9M665R3vpETBQNtpHHAIn4uRu9iAIpRrWJVlkrzhq/wUn3sMuoA6R
         qxeLPfEDw7wQyo+BM3gr05V5/7WwdVTr44qIfMVhVZLNNi9J/JV0nmZIN2TiJsMuLAcK
         QxQw==
X-Gm-Message-State: AOJu0YyhJzOaqjmHmr8gzGdmyaBcRSng9NGovo7aEGVu2Y9AYMB6XwOK
	Kr9fKekDoN2K5bqxmFywd+fi0wn5oXONRWvqja2TNVUVunYJatCW8ixGCdL3EOXY
X-Gm-Gg: AfdE7cn/gdwGkp54w53e8QqrMImgv8gT5c2+tjlRhtttLvHKteS5ysCYdRJ9b6cnnk6
	F5+Pa871NzMXemB/ctkcsAiGAEbKY54cEUmFneYY+hpep43SXBG54auKGX9myDqE5GDoBlxAw6s
	ZaISD7D/OXb86fYxWLLUTWD+NsIFW9JrBAUoPRCfPLwZqml3wGadQEL6kMdFUStxVUuAjAqPXt0
	R9S6Mtqw/3Qx1hkIA7iczITYkJP5slp9driZv0wbncpr535xxalthkki+CCCsSHVrYgMk2Bzq1I
	zChRC5BCN4qe5Hft4MtVrS+S+zOe/o5fk73AhhjR1qZRSCeo4DJNB4EjWhx7Odx1SpgMDcJg48l
	16Xdfd9xvYdlCTW3omzXCFc81+WVPf1Af7zCs/9aKeU5AFXk3dlqFHWQ/HL92CbDN5D1GX0IPgS
	OSmrcqWo92GkG9T4revHTeAiPsKitcb6f+ukpM2g==
X-Received: by 2002:a05:693c:88c8:20b0:30c:9bfa:a636 with SMTP id 5a478bee46e88-30c9bfaa8afmr4164281eec.22.1782558671803;
        Sat, 27 Jun 2026 04:11:11 -0700 (PDT)
Received: from fedora ([116.73.171.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm29790015eec.28.2026.06.27.04.11.10
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 04:11:11 -0700 (PDT)
From: PrittSpadeLord <pritt1999@gmail.com>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] minor spelling and grammar fixes in doc
Date: Sat, 27 Jun 2026 16:40:12 +0530
Message-ID: <20260627111012.1819186-1-pritt1999@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aj5mYeKqJkJBmpin@chamomile>
References: <aj5mYeKqJkJBmpin@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13491-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[pritt1999@gmail.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pritt1999@gmail.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F76C6D1D09

Sure, I go by "Pritt Balagopal". PrittSpadeLord is my GitHub and GitLab handle.

