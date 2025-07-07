Return-Path: <netfilter-devel+bounces-7754-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69CAFB7A7
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Jul 2025 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D671AA0D1B
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Jul 2025 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA91E9B31;
	Mon,  7 Jul 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yr0XVWux"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA11E230E
	for <netfilter-devel@vger.kernel.org>; Mon,  7 Jul 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902883; cv=none; b=slvITvL7L9WrVvJ3zIDT/pNYeHGbS9T7IPovIXMQgAx+h49SN/HICiZ6UeHTWak03q62e1f9c2HZU5NxTtUZeZD1mb318fzGE+eC8+d5co8hSYcgYreqphN7Ab9TNZuhmDuUPudB2+JkRGwQ05xOVP221Wf9EmDej41DbOejLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902883; c=relaxed/simple;
	bh=ePOPubuWj17eRi0sYt5gn5zhUwG2cej8IddcFeCTXXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ce9AiQp+jjdTafVksCjumUAAdVCKGh9iCbkpm/1EfqumfUsAOYIhTBo5DLK5GI9FzE8u5fIsnHRoVmblNyxXPlnZeV0N6ccocrw/12dxPmLscW56xlWuOHDSQybhh46RL6a5j7s1f/jXd7mps2b+OZqUV0E1uLnoy3DmwR+e31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yr0XVWux; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751902869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3RrQWA0hl2m0Jg5mJm6780LOhvTRsObdRFSzyTIGtE=;
	b=Yr0XVWuxfD334RtnfP0rxbc+BWxrdqSYqtRltclNSQJe/WG7/ZAUAZLPOgQonXSIf4O+zi
	wPVs1mBAUazhpSsbztZiS7Vy3GfvHYgBMk2/BCsd/u0L258ep/8V8if24dVPYCtugI+bqE
	7JRo1lDd8eyvUhNFvmxoanDff6hGxyk=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 0/6] Move attach_type into bpf_link
Date: Mon,  7 Jul 2025 23:39:10 +0800
Message-ID: <20250707153916.802802-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Andrii suggested moving the attach_type into bpf_link, the previous discussion
is as follows:
https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com

patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
will init the attach_type field.

patch2-6 remove the attach_type in struct bpf_xx_link, update the info
with bpf_link attach_type.

There are some functions finally call bpf_link_init but do not have bpf_attr
from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
now use prog->expected_attach_type to init attach_type.

bpf_struct_ops_map_update_elem
bpf_raw_tracepoint_open
bpf_struct_ops_test_run

Feedback of any kind is welcome, thanks.

Tao Chen (6):
  bpf: Add attach_type in bpf_link
  bpf: Remove attach_type in bpf_cgroup_link
  bpf: Remove attach_type in bpf_sockmap_link
  bpf: Remove location field in tcx_link
  bpf: Remove attach_type in bpf_netns_link
  bpf: Remove attach_type in bpf_tracing_link

 include/linux/bpf-cgroup.h     |  1 -
 include/linux/bpf.h            | 18 +++++++++------
 include/net/tcx.h              |  1 -
 kernel/bpf/bpf_iter.c          |  3 ++-
 kernel/bpf/bpf_struct_ops.c    |  5 +++--
 kernel/bpf/cgroup.c            | 17 +++++++--------
 kernel/bpf/net_namespace.c     |  8 +++----
 kernel/bpf/syscall.c           | 40 ++++++++++++++++++++--------------
 kernel/bpf/tcx.c               | 16 +++++++-------
 kernel/bpf/trampoline.c        | 10 +++++----
 kernel/trace/bpf_trace.c       |  4 ++--
 net/bpf/bpf_dummy_struct_ops.c |  3 ++-
 net/core/dev.c                 |  3 ++-
 net/core/sock_map.c            | 13 +++++------
 net/netfilter/nf_bpf_link.c    |  3 ++-
 15 files changed, 79 insertions(+), 66 deletions(-)

-- 
2.48.1


