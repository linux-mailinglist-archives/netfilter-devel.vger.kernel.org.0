Return-Path: <netfilter-devel+bounces-9475-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43AC1545F
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Oct 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F851894E49
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Oct 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2B253B40;
	Tue, 28 Oct 2025 14:54:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A9264A86
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Oct 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663286; cv=none; b=BNOkHMio7BXRH4SdqV9dRyqKVoiAD0qWxAKvV/By5sGGcIG9STjoSApjdFTQF79buhW9OVUwIZJG14dw0ZRsl+oZc3tocjRtnHCc63+EXfJgU3a7gRJrhO2Yoae+Id/7YqNCtLyCfKrfHgAKjgHbGJTpb5UoVignul2moX/DIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663286; c=relaxed/simple;
	bh=6+A5aI4V1JNW4Jk5RqMFS0XCW/4NKnWcovglKq293jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQ0Yesggudy1Kg9dtj5ed6sRKeSdWEPkDvZugnke8GtonK3GLe2iADW7UyNcedGuoU2viikQkNuVRrEeuapgDfPapPRQcBfJu/iI9SNSa5W2kHSh0QTTN5+PE4GncemoKZ05fxd3zCUcZoAvjR8k4E42PzdyQMza4Ilj16x72ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D349E61A31; Tue, 28 Oct 2025 15:54:42 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: mail@christoph.anton.mitterer.name,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v6 0/3] doc: miscellaneous improvements
Date: Tue, 28 Oct 2025 15:54:26 +0100
Message-ID: <20251028145436.29415-1-fw@strlen.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is a rebased and slightly condensed resend of
Christophs documentation updates for nftables.

Christoph, let me know if you are ok with this
and I will apply this some time tomorrow.

I applied a small chunk from v5 to the tree already.

Christoph Anton Mitterer (3):
  doc: add overall description of the ruleset evaluation
  doc: fix/improve documentation of verdicts
  doc: minor improvements the `reject` statement

 doc/nft.txt        | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/statements.txt | 34 ++++++++++-------
 2 files changed, 112 insertions(+), 14 deletions(-)

-- 
2.51.0


