Return-Path: <netfilter-devel+bounces-5017-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A972B9C0D2C
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2024 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E430B1C229EF
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30E2170B6;
	Thu,  7 Nov 2024 17:46:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8813AA3F
	for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001601; cv=none; b=MI/mFdXh0/hWTZSGSPicXqfFL/Z6XX2YU8w8vZ+PMynxoCn/o2aDRSDxU6k994Mo7oXERPjC0gJ3v/W/j4SUGgaXPJYM82Jo2aai0P06CT0EBFr8UJgWaezCO1AhhQu7JlfJPI7dPxI2Yy54Qd7PoTO2SkermRrG3WempkZ0X3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001601; c=relaxed/simple;
	bh=wo4RxHw+yOJ8gms3H4L6O3nlxKiD91f2AegEY1JegTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bfis2SFab5Cu4pVQHGhD5UaHFYAo5wrf8iPTqa7vuS7egTbQZrvyY1rcSozEQXTv545R2uVBFZdWPlJEFQdgGASyGACyKga9x06YgHXLzPEahbCiGnAe7AynXTMmRrohX43OBsgsp1GnSvMlYj4n3YEZkKZyakU9WuPdY0ItRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t96aa-0007Kh-M0; Thu, 07 Nov 2024 18:46:36 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 0/5] netfilter: nf_tables: reduce set element transaction size
Date: Thu,  7 Nov 2024 18:44:04 +0100
Message-ID: <20241107174415.4690-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4: fix a typo in patch 3 commit message.
    rebase on nf-next:main.

No other changes.

Changes in v3:
I failed to realize that nft_audit leaks one implementation detail
to userspace: the length of the transaction log.
This gets fixed by patch 3 which adds needed helper to increment
the count variable by the number of elements carried by the compacted
set update.

Also fix up notifications, for update case, notifications were
skipped but currently newsetelem notifications are done even if
existing set element is updated.

Most patches are unchanged.
"prefer nft_trans_elem_alloc helper" is already upstreamed so
its dropped from this batch.

v2: only change is in patch 3, and by extension, the last one:
During transaction abort, we need to handle an aggregate container to
contain both new set elements and updates.  The latter must be
skipped, else we remove element that already existed at start of the
transaction.

original cover letter:

When doing a flush on a set or mass adding/removing elements from a
set, each element needs to allocate 96 bytes to hold the transactional
state.

In such cases, virtually all the information in struct nft_trans_elem
is the same.

Change nft_trans_elem to a flex-array, i.e. a single nft_trans_elem
can hold multiple set element pointers.

The number of elements that can be stored in one nft_trans_elem is limited
by the slab allocator, this series limits the compaction to at most 62
elements as it caps the reallocation to 2048 bytes of memory.

Florian Westphal (5):
  netfilter: nf_tables: add nft_trans_commit_list_add_elem helper
  netfilter: nf_tables: prepare for multiple elements in nft_trans_elem
    structure
  netfilter: nf_tables: preemptive fix for audit selftest failure
  netfilter: nf_tables: switch trans_elem to real flex array
  netfilter: nf_tables: allocate element update information dynamically

 include/net/netfilter/nf_tables.h |  25 +-
 net/netfilter/nf_tables_api.c     | 368 +++++++++++++++++++++++-------
 2 files changed, 304 insertions(+), 89 deletions(-)

-- 
2.45.2


