Return-Path: <netfilter-devel+bounces-11496-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AWUGGp7ymnk9AUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11496-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 15:32:26 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA135C025
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FE1B300E2B7
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1F260565;
	Mon, 30 Mar 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OccewnNk"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FC2580CF
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877543; cv=none; b=cmcouGjqusculcodxi4mJ/nIZcis1CPdPu44hrxtg6VM8aQfOjfLb95FIAQjMYdvbVyqv14yD3n674SKOpsHHu7tCL4iP+YDWGRkSCj0TEDCDLOxz2IMWspFdpstVTsb1y2HA1vHE1yxArT9tBnmdC67O0A0PKLGIaaDkokK314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877543; c=relaxed/simple;
	bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z84IRpaT6q4Mic73Uex8rE+SOoQr9bzhkSgZTmiHJOmqz15XtGnI9sBQLpL+dqpa9F2/z90RKoKTzlRgBfWEW77CLuRdj9LhXcF4UcPrRNtFpJhMHojKf/Fr4rC4DIMIi2+v56nQ95ZjyPKmkRSjNuvfe7rmYbnE8I6G6XwNEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OccewnNk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1846648a12.2
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877542; x=1775482342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
        b=OccewnNkRuoq9J8SATNCTzhv8frRTEs8F2qnGxiXCf+jxB4TOa48lO9UZyNwRNmVyi
         /nNvn/bgTBg03E6Kq8hBgo8oeDI8q2JCY2EqIRE4W/BffQgRRqC5oOvPqlWKUwqXbCHE
         T5Fzha26GPgZxmxqhG7S7jl2ExTK7JOqgzuUgk6m3ge3kTskfRn1K9Rg9h0XkE1IdUhj
         VhyPJdEC+Doj/U7SmEFNp62zaGpvRQ6msk1Kliz+hA3qRadVHaHd6i+9zQWAirGD2X4f
         fapnta+7vgj94QtYeVq7TR+NKCavB2+gNQo4gxFTq8IQKqRDNKu6W1EIoynykKpKbPnz
         MizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877542; x=1775482342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
        b=aTxZcGfHpqGDWRPM6TFsBrA38Py74tZFPj0L+76I/d1u8XdY6tFLH1BnnDGP2jNYGk
         vHV1IsmwrpJMjaJg1SiU/N7kC4B7GPUG3ELXX6UkELVGNxKSOztQnA3os0JhGK5dAsYX
         mXxNMzlTGVNBXFdiKzOqEQl7l4oFWuJxduMVPbVoa6XxtteXcMytVuVQK2zsDnPrppYO
         HSrWqUDHalZ3rlKy7ZS3W23864dz/yFf2gK02GTnCuZqN/+m8CpV3x4kNRyMIjLi5l9X
         tE2/CKQWOi/eOG7CHrynZMgKKQeGprHwiwVJM1G8Cpilys4eJx4MEVAW++dITrqOE990
         avHw==
X-Forwarded-Encrypted: i=1; AJvYcCVwcBwjm0frVOulS9pQ6TYYSL8N7qr/XlD2rNW//5RZOs9NH8zwoil4tWWE6TvrV/2BKtIz5IXL9CCbvD8FBi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+LS6FbN/eMrYckel/+jWt9lVe5IolHSt4jFY0vXb9VCVXYRe
	0GjqvlfYQLoX5n+4tEUhw/R8iUuYvja0Stg/6Q1oBH1+aThGYK0pMjvH
X-Gm-Gg: ATEYQzz3BIbucLPXat+OFIZHOLONcUG05UfBBoe94+HG4S7natJMzcXh2+40O/FIUeg
	96I+T1jb8fb9irDtNqbrrsnKh8pR2nRmelcO2VGpfjWncHHi9oVC4yakcdmKzkNtymX3sZU7uCo
	U5XuzmgOLCBzZ/pjZT4ioVHov4cUTslVjd+kN6CMlmPbLb5Fox+j4kYJly0zh6VOSeD/FVh/VBa
	bHNHiiJAIsToVVtCQro5fUQsE88aYOerXJLtA6gYK2tEEv4/wgKZvFwjcd7nlupEcffDDADwTs2
	Pl8YWdiPBSraQEBfDroSeyEj3epdn58TCcCU0dy5PU82NWMp8lWVu9oD4g1DzyZZwb8EzVkYM+f
	OF4m/ykzJ17JXz5Nnj8Kmh5M5oTdv5uqbskRis4eLISFjVCAUJCcMj7TVFiYcS0mj8QxPb75Y6U
	f4wD30iH27jHTXMu21lNk+CcGhI2XUYwZQksk=
X-Received: by 2002:a17:903:2408:b0:2b2:54c1:2067 with SMTP id d9443c01a7336-2b254c120d9mr33320645ad.21.1774877541967;
        Mon, 30 Mar 2026 06:32:21 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm99601525ad.72.2026.03.30.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:32:21 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] netfilter: ctnetlink: validate expect class against master helper
Date: Mon, 30 Mar 2026 21:32:16 +0800
Message-ID: <20260330133216.241532-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acpkPEJRvzeY863Y@chamomile>
References: <acpkPEJRvzeY863Y@chamomile>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-11496-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05CA135C025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:52:36PM +0200, Pablo Neira Ayuso wrote:
> Better to ignore the helper name proposed by userspace when creating
> the expectation.
>
> The master conntrack must already has a helper, and such helper must
> be the same that is specified here.

Agreed, your approach is much cleaner -- removing the separate helper
lookup entirely eliminates the mismatch class rather than just
patching the validation side.

Thanks for the quick fix!

Qi Tang

