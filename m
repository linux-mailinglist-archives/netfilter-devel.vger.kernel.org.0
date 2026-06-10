Return-Path: <netfilter-devel+bounces-13188-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T777HMo/KWr8SwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13188-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 12:43:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AF668646
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 12:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pmq7aeQc;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13188-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13188-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34E9F300D726
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EA3AC0DD;
	Wed, 10 Jun 2026 10:40:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4E372B5E
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 10:40:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088029; cv=none; b=B4/VoQ2HAjECK+deEnK2kh07RMK0PhaqCTDpX3ucJA4uCM8cNxYvqGkjVdZ9eMQA4ozOB61cK3FLM1opyttTH0mEImzBhFn7lCnJgqYyzTgicj2JinnyulFgbAByCNmfhEkT048txtK5/ljapRGD9f8f5/FDD3ME+uMzRx4h+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088029; c=relaxed/simple;
	bh=6lWsX1dY4Bc3CHw2VJlFjmqICb7q6oltLwdNe7HFv7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIRpM3HwvA0G28UZhV36FuMe2KzELMml5h+M4TmO2EUc44x07sd6+d0Hko66NQKaDV7yk8f3vSxeYkY3N6YjWpMTKSPaFk9Rwm2X4MlaaVmsWbaDM1+XbJr2/cSQPzFWWx7huSFRCfun0PpF/vVgYgSu34LBxlAEqjcf4/O71oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmq7aeQc; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef29c5561so3563282f8f.0
        for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781088026; x=1781692826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O5QZoiM1vL8P2LHIc91g/yOHWKTjUEVnmNOhiYszlOA=;
        b=pmq7aeQcYqx1qzl3LJdWEEjjGzujIm8IbTO7XzxkzA5M2Ta0HtAo0j5zxG+s4box7J
         YCUyCvPmAsYOygSar9BrqxxOo8/qUPr2dLKcv5cbu6soHqzKvnSGywDcsny050doDZMp
         gfA2t6ili3depLJNr0UjjyroyE4r/FPvWM/vZI9EJ+hA4NCYGnUu0E6MZfGjjA0lpwb2
         d4k45Eg1+XfiVimrjOep+uxeuGXG6Wn2WocswBT1kpu59K0rqIBe9Aas3vgOfSqP9Wsk
         0kRSGfmJM//n7O9iN4aUAbRAwng8RfLsYvY48h3a10BjuGvG/4aierSgdwNV/6mXvjQQ
         z6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088026; x=1781692826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5QZoiM1vL8P2LHIc91g/yOHWKTjUEVnmNOhiYszlOA=;
        b=h3KrSXi339on9ikIsmrsYfi8A+38hHg1iH4dewJM5oTm6UFbYfl4k8SFh8iR6oCZa4
         00wjL1rTG41H95ezMdN8wyOeekaOujb2zE+Dlu5sG8GDnul+AumQxggn3aPTdYfGgOb7
         nOTfWEIy8CUJkNoYzqNkTP6IcmK54qjWh/HlM9KxhjA6+ksMv/vzNBw1/n98HWWQ4kyL
         TqtfMvxe4+zfeftPBgYffIifoHJ/ZDNUSCdBHnpwDcVIugzj5UxPLQQXViFuRrVJ7P6z
         EMU2bu988r7Gnf9dmIL+I2WgjFcCksBQ23eRZDf8F58KUJejVhPZa2QpvBGK1AGHFLoc
         u2qQ==
X-Gm-Message-State: AOJu0YxMg/d6Da59VhGsDRf/PBHNnCs7k7TGwqqxrxKk2f3UKL5X1bNO
	EJJ4KBj+Rx5XaBoexIkFrWstoAe3u9K9aGgGk1PgOb+B6zCNsoRofzZXdMiRsBVf/Kg=
X-Gm-Gg: Acq92OHm5XzHYofvrkgCrJu2l8XSwpXRpHBeciKCSGGlpMAv08+l18vqAYexJpZp3L5
	Z7RlBkRnPU8kIMGcKJdqXhAu+yri0/jYsqBSJe2qC+UQn9F0rGl7+xfkenAv5bKdnbNmAyEHaT7
	dYxInoEwyWcfuijdox/Lvux/MnkEG30qF9jmgBYMcGMp+V2Tq38X1swLR6MhGbJ0HjmyMKB18OQ
	+bLAQnmpKA/+CCpxZ7HUxa0RhKQ+efCKl7jGEej2W3BXDGUi8D3PeFN9uDMVZRUsGAHIzKF7qcv
	G88ouUgQcmgLNPT8Kk3lSQszAjpJIwFO42Wp8et3aZJo0e53H/BDk7wJnjTTwuWYHlUrpEfc3Lv
	pisCD1O0DqX+cEDbohslT3OSOGZpXqSTpyMaN9BecC4acviQciiE4s5G6RP5HxWNAzqKgCpsTqh
	6LigwpVm7bEAZqrU7M7K9GRIeHk52dgNjIXvqi98T6qQn1u7a68uQ02FYWE4DMkK128m9SL2vpD
	tnT+t2B+Q==
X-Received: by 2002:adf:e848:0:b0:460:cfc:eb24 with SMTP id ffacd0b85a97d-460304fec2bmr30694864f8f.22.1781088026328;
        Wed, 10 Jun 2026 03:40:26 -0700 (PDT)
Received: from manta01.. (host-85-36-215-182.business.telecomitalia.it. [85.36.215.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm75828687f8f.17.2026.06.10.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:40:25 -0700 (PDT)
From: Davide Ornaghi <d.ornaghi97@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	coreteam@netfilter.org,
	Davide Ornaghi <d.ornaghi97@gmail.com>
Subject: [PATCH v2 0/2] netfilter: fix two remaining stale-stack register leaks
Date: Wed, 10 Jun 2026 12:39:11 +0200
Message-Id: <20260610103913.1949008-1-d.ornaghi97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,gmail.com];
	FORGED_SENDER(0.00)[dornaghi97@gmail.com,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13188-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:coreteam@netfilter.org,m:d.ornaghi97@gmail.com,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dornaghi97@gmail.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E84AF668646

These are the two register stale-stack leaks that remained after the
nft_byteorder (CVE-2022-1016-class) fix, the nft_exthdr PRESENT fix and
nft_ct (3027ecbdb5fd): a producer marks DIV_ROUND_UP(len, 4) registers
initialised at config time while the eval writes fewer bytes on a
reachable path, so a downstream consumer reads uninitialised
nft_do_chain() stack and can leak it to userspace.

Both are minimal, -stable-friendly fixes that make the eval write the
full declared span. The broader store-helper rework discussed on-list
can supersede the open-coded stores in -next.

  nft_fib:         OIFNAME early-returns and the PRESENT flag
  nft_meta_bridge: IIFHWADDR (6 bytes into an 8-byte register span)

v2:
- nft_fib: also reject NFTA_FIB_F_PRESENT for result types other than
  NFT_FIB_RESULT_OIF (Florian Westphal)

Davide Ornaghi (2):
  netfilter: nft_fib: fix stale stack leak via the OIFNAME register
  netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR
    register

 net/bridge/netfilter/nft_meta_bridge.c | 2 ++
 net/ipv4/netfilter/nft_fib_ipv4.c      | 2 +-
 net/ipv6/netfilter/nft_fib_ipv6.c      | 2 +-
 net/netfilter/nft_fib.c                | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1


