Return-Path: <netfilter-devel+bounces-10635-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGTLDHIDhGmHwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10635-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:41:54 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD3EE0A6
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A45133006989
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBF2C08B1;
	Thu,  5 Feb 2026 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="mbzdliZF"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B12C0307
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259296; cv=none; b=Qxl06FMuQsGGF34iz13KD7lqRLHdfvLKl4pmSZIIAvTsPtzh8veZzVdV49/vynywueRM3ZXHGa1o72jIp/qUorCjOL2c+ggiNy4y8EKRXEfYqb9wG9R2P/NIKGKb/OPo1qNgMMWQLAWBMHOpSX3zhd90J4KQlDXXVNxWN1AhyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259296; c=relaxed/simple;
	bh=ouES9NekOX1T2D1Mg/06RgcRMKgKDsiv4jQ9lpXk+Gw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TFUr5CaTKA7Bh12nASXEi+0RcxqJ+yyVZBJjgxppz08vh+oyjB2pQ/tW3kLJO7BtYCLomYUFdaTRRYyjffS9Vru/3M03K50JPULR4/53QmHzMZHKNltGwB7mT/YTslXAJhzyhBSeWiNhMMrzNzW4Gk1bry823tmJFsOU/HFzH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=mbzdliZF; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id CA68E60871
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770259293;
	bh=q+D0O0IMu6dwhI05wWBiBopzfnRBcIzXGYZhTLP1qc0=;
	h=From:To:Subject:Date:From;
	b=mbzdliZFK7b8usmIVKjs5L+rpOIoITjXK3Wbhpj50jz5MEhfvVPxSToPA+EQFq8jt
	 IV7rk6w6hJ+4w0QoD+d0nVv16plJHVX/bReCXv6I3nxLkprH+iTuHqwrLz0RHjo35Q
	 7cECA8kloe+NoLw6ancM3lQD0MYwS2IQIdNWmzab5h7w9vpd8w+e7TkKlhxmF7xif1
	 dP9AigZGAZMRKBJB/8Y2aH6V6DWCsEnswVnNwKnRTmBtKPeXFC8yzjKhiGszMZXRIT
	 Ct5jEWm7W5EY6kdbRwY8YkGM37F2+WiALlhcE9VRP2LmA58etHU8xFdyalNA46LeX/
	 R06fGa525KACg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 00/20] prepare for EXPR_SET_ELEM removal
Date: Thu,  5 Feb 2026 03:41:09 +0100
Message-ID: <20260205024130.1470284-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10635-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:mid,netfilter.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ABD3EE0A6
X-Rspamd-Action: no action

Hi,

This is v2 of the update to prepare for the removal of EXPR_SET_ELEM.
This series is slightly larger than v1, including more preparation work.
No functional changes are intended. No memory footprint reduction at
this stage. This slightly increases LoC because of the patches that add
assertions on EXPR_SET_ELEM.

This is passing tests/shell.

Apologies for this large series...

Pablo Neira Ayuso (20):
  src: normalize set element with EXPR_MAPPING
  src: allocate EXPR_SET_ELEM for EXPR_SET in embedded set declaration in sets
  src: assert on EXPR_SET only contains EXPR_SET_ELEM in the expressions list
  evaluate: simplify sets as set elems evaluation
  evaluate: clean up expr_evaluate_set()
  segtree: rename set_elem_add() to set_elem_expr_add()
  src: move flags from EXPR_SET_ELEM to key
  src: remove EXPR_SET_ELEM in range_expr_value_{low,high}()
  src: use key location to prepare removal of EXPR_SET_ELEM
  intervals: remove interval_expr_key()
  src: move __set_expr_add() to src/intervals.c
  segtree: remove EXPR_VALUE from expr_value()
  segtree: more assert on EXPR_SET_ELEM
  segtree: remove dead code in set_expr_add_splice()
  segtree: disentangle concat_range_aggregate()
  segtree: replace default case by specific types in get_set_intervals()
  segtree: consolidate calls to expr_value() to fetch the element key
  segtree: use set->key->byteorder instead of expr->byteorder
  evaluate: remove check for constant expression in set/map statement
  evaluate: skip EXPR_SET_ELEM in error path of set statements

 include/expression.h      |   5 +-
 src/datatype.c            |   1 +
 src/evaluate.c            | 151 +++++++++----------
 src/expression.c          |  58 +++++---
 src/intervals.c           | 300 ++++++++++++++++++++------------------
 src/json.c                |  42 +++++-
 src/mergesort.c           |   8 +-
 src/monitor.c             |   2 +-
 src/netlink.c             | 105 ++++++-------
 src/netlink_delinearize.c |  18 ++-
 src/optimize.c            |  52 ++++---
 src/parser_bison.y        |  12 +-
 src/parser_json.c         |  14 +-
 src/segtree.c             | 230 ++++++++++++++++-------------
 14 files changed, 559 insertions(+), 439 deletions(-)

-- 
2.47.3


