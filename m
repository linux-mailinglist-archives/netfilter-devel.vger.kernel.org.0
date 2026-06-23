Return-Path: <netfilter-devel+bounces-13415-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g/TVF6fAOmp/FwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13415-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 19:21:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F696B8FFE
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 19:21:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="FN/ewL+X";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13415-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13415-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58643300B9CB
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4E360EC0;
	Tue, 23 Jun 2026 17:21:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A251215075
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 17:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235298; cv=none; b=bbvUuCfzxgcv/jdq03+UQgLlEMBbsVUceSGVG5eqPlRe2kDgcIM1pXa91QjKkKL94etYiDb9UyxTmpCm6Sa55T5siX2zn6BQ2FxYj7wHNHWULEgdSXBE2vP030R87Iql+E1RA/Z1PBn06FBUIxI5oxuVktd/GGUghqyK/Pxmv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235298; c=relaxed/simple;
	bh=t0OL12Bc6wP+9J4mksldsMKJMnTjUCvxKOS+rUnfQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gn+4ebCFibmCkRTKjn6ywLm/C2IX8CFwkE8xZYTrdbrejD/vi029HXrj7yiI5SBqSpVgI62wWAKSLuYJ7dmVneI+05KTuYqsIret0UdlxmEOXu0aaErFdvTISoDVG4e5Kj9QDoJel8nVV6NO44k4uNdnbOo+I7wlF8KFYCxJBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=FN/ewL+X; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D0C2E60193;
	Tue, 23 Jun 2026 19:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782235292;
	bh=mjfjbAG+PsC5Lo1ODRjj3ha+bPiXu0aD/d2o0oV51/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=FN/ewL+XQ6e6q5kLMOMwnclgrJOdvBmRI4tKpkHiaKbQ2WcYoGIBZ3FEH7ivlJ45B
	 LIqjVURpyCm2nYASCtvJTH6n4O9OMWQMi7lCtpx+SYPC6VkZsACoS6L2+aM1qMH6jA
	 YO34bsheSFc/EodRVjto4iwIBorAf77J6En3AAgpIOWqW59APtW+7QvhtmJseJ3AEH
	 k5MxzJ70pYfi0top3dPcKrGRVMC71vwboNEwr5rt0VQNb1o+lIUSuQR+c+UBYzrfSJ
	 0WdlChXwzVHmD2Efsejx9gE1PVgWZ+VZisSQ9htTLd8t7huzpl6XQafyxmdHsHaZ42
	 0puyPnj+itAbw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc
Subject: [PATCH nft,v2 0/5] support for several list and reset commands 
Date: Tue, 23 Jun 2026 19:21:23 +0200
Message-ID: <20260623172128.401234-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:phil@nwl.cc,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-13415-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ozlabs.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06F696B8FFE

Hi,

Currently, it is not possible to run two reset commands in a batch, eg.

  nft 'reset rules ip x y; add rule ip x y counter'

this fails because the cache logic gets confused with the requirements.

This approach runs each reset command separately, fetching one cache
for each of them.

This series is a follow up to:
 
  https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=499127

to address an issue reported by Phil Sutter.

In this v2, this round simplifies the logic, allowing the combination of
reset commands with list and get commands only by now.

Patch #1 to #3 consolidate common code between nft_run_cmd_from_filename()
and nft_run_cmd_from_buffer().

Patch #4 add cmd_batch_add() and validate compatibility of reset command
with list and get commands.

Patch #5 adds the cmd_batch shim object to collect sublists of commands
to deal with several reset commands.

Pablo Neira Ayuso (5):
  libnftables: add nft_run_cmd_release() helper and use it
  libnftables: split nft_run_cmd_from_buffer() in helper functions
  libnftables: use nft_run_cmds() in nft_run_cmd_from_filename()
  src: allow reset commands in batch with list and get commands only
  libnftables: support for several reset commands

 include/cmd.h      |   9 +++
 src/cmd.c          |  59 ++++++++++++++++++-
 src/libnftables.c  | 144 ++++++++++++++++++++++++++++-----------------
 src/parser_bison.y |  12 +++-
 src/parser_json.c  |   8 +--
 5 files changed, 170 insertions(+), 62 deletions(-)

-- 
2.47.3


