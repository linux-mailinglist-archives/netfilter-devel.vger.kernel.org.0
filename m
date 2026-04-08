Return-Path: <netfilter-devel+bounces-11727-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FUEKTxE1mkFCwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11727-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:04:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEF3BBB79
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C48D3303BBFF
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF803B8BA1;
	Wed,  8 Apr 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="iuzd1VJg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19473B27F9
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Apr 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649574; cv=none; b=OQ0cFU+CPs486Kaduq+zVKowuhLq/Mq7YIFjcM0rxsM/+MQn8nNatt4wDi3vw8TUHxn01iTpWUgIVXikI7nEAkTtEoPQu4aNH0QSwv8p/SKMpnuVbG+S8JtNLSWwm9uUr7KD9jjJsmJZ1bcOFKHRPH62UXavslOKHhDQrwIBJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649574; c=relaxed/simple;
	bh=2MjC5VNZm6To9bNvwN9eeGPeAMXqmUphZQ75Dljp8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N17H4QfpULugSpgH7ErNkFlFaFQt0pbcwo0IrB9ZEpEOh/2vCr76nEAYhlZ6yCbH6X3tj6GaL/L1Fgj4We2e+Jgw7AN/ot+s3orMsP5bWXPJ5aKk1TEAGoY/u1G3/HD+gE7nR5AopGMYcyr2Q1+OwPYsWJVptmKQJE5UdZNMvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iuzd1VJg; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 1A41760337;
	Wed,  8 Apr 2026 13:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1775649568;
	bh=8G2ELB2sHrUVwCIt96IH8En0a1242BTbK/uFKVH7C50=;
	h=From:To:Cc:Subject:Date:From;
	b=iuzd1VJgtGjkd1wtrLytT++rDuI77TXo6qbJJ3goSjDtERS9PdpCixP/RwpVwveAl
	 pPT2s1fTJsjsJwpMEnzXoKbnZgr/EgJ7Spk3PZ+kqx4gT+orzftQZ0ncs7dzdcbinP
	 LFN7zKYOcu1QjK7FhWwyFuxgFGGnYLw0lnd6WSS3UwJq8yCMfRMk6Tug9wFk/1gevF
	 L32Hogekna2UeBCIoXGCOwj2a5C5FkPaUdd6+qZ6qicAm7FCo1kYLwV24Faynw52ju
	 SvWgi+6uPaFoOmiddBz3L8PiKf7P5c612ub5bukL7eHqe5VxXKxQYZ4dwEakpwUhuq
	 Rt0yDjjotyEEA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	fw@strlen.de
Subject: [PATCH nft 0/5] support for several list and reset commands
Date: Wed,  8 Apr 2026 13:59:17 +0200
Message-ID: <20260408115922.48676-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11727-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:mid,ozlabs.org:url]
X-Rspamd-Queue-Id: 9FAEF3BBB79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Phil,

This is alternative proposal to address the issue reported in this patch:

  https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260311194100.21983-1-phil@nwl.cc/

On top of this, it aims at addressing a longstanding issue, which is to
allow users to add a list command in their .nft files.

Please, see 5/5 for details.

Comments welcome, thanks.

Pablo Neira Ayuso (5):
  libnftables: report EPERM to non-root users with -f/--filename
  libnftables: add nft_run_cmd_release() helper and use it
  libnftables: consolidate evaluation and netlink run
  libnftables: use nft_eval_run_cmds() in nft_run_cmd_from_filename()
  libnftables: support for several list and reset commands

 include/cmd.h      |  10 ++++
 src/cmd.c          | 100 +++++++++++++++++++++++++++++++++-
 src/libnftables.c  | 133 +++++++++++++++++++++++++++------------------
 src/parser_bison.y |  12 +++-
 src/parser_json.c  |   9 +--
 5 files changed, 203 insertions(+), 61 deletions(-)

-- 
2.47.3


