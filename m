Return-Path: <netfilter-devel+bounces-13281-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +egzLoTiMGpNYQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13281-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 07:43:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8968C3C7
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 07:43:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=CDljHQDG;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13281-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13281-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A2230C1A10
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 05:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F33D6CC7;
	Tue, 16 Jun 2026 05:43:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413273D5C3E;
	Tue, 16 Jun 2026 05:43:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588605; cv=none; b=I04JucIIc2kKiKKh1edeHtcWfWToAQIQjLTp2MLydPhwQ15m1uQ9ofBGNk9kFaYe9uLs4PlvMZdiBJ0tfKS+Zz9gx99LpXCuUcPWKt0kc+7zCMay4piS3E7glKjuKpfr1E7r0AxXCVCApLamTZHP4UIbNvdPpBgmD+RkNDJ841I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588605; c=relaxed/simple;
	bh=aox1OEzILyupUKRfAf5WXYTLGdCgpSAUw1nXj1c9c3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGYIm7QF4Q80TiUbJgma+9WgCFn1Mr0+JbFES3DztWDwWtL56zqXsHlKYYk29h113s+WBkFIVx/f9zkpAIfpmKObSOVcUSDA3VCov9kbxBV1yBUvH4l43NYXMBDgVFmyBK9OvJmtSNqPppesWHkaQgsi0yx8ouYjcxgPK7RtaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CDljHQDG; arc=none smtp.client-ip=206.189.21.223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=2rtcz
	yrLWjdHUmehNAsDWNO7AjrwAppVwrlY8MnURsc=; b=CDljHQDGyicQPFl/SEJIF
	P5Bblv4tyJwIoSH7kTotIb1nhjT/k/DUk/qVM0TWZgd/OAb/Dg6TEbzJ99Iho9bV
	RoZGrolznZqWW4Dm83FMsUgrZxI/ApHNNWtWApzbwdr7SYr8SR5Ogl8qxUX5XTj3
	pTRh/WvXRpioiwOdwmDaBA=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQBXMZlM4jBqXCpTAg--.51787S2;
	Tue, 16 Jun 2026 13:42:45 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	kartikey406@gmail.com,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Guard conntrack opts error writes
Date: Tue, 16 Jun 2026 05:42:33 +0000
Message-Id: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBXMZlM4jBqXCpTAg--.51787S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45WF4DtF4fZFyUAr1DWrg_yoW8Zr17pa
	yrGwn0yr97Jay7J3Z2vFW8tF15Can7A3yrCFn8JryrAwnaqry8JFWSgryUWF9xGF1fZw1Y
	vr4Fgr98Cr18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRqFAQU
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13281-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chenyy23@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:chenyy23@mails.tsinghua.edu.cn,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenyy23@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53E8968C3C7

The conntrack lookup/allocation kfuncs expose an opts/opts__sz pair.
The verifier checks the caller-provided opts__sz range, but the wrappers
currently write opts->error after internal errors even when opts__sz is too
small to include that field.

Patch 1 writes opts->error only when opts__sz includes it.
Patch 2 adds a bpf_nf regression check that keeps a guard in opts->error
while passing opts__sz covering only netns_id.

The regression check follows the existing bpf_nf test shape.  Before the
fix, the guard is overwritten with -EINVAL even though opts__sz covers only
the first four bytes of the options object.  After the fix, the kfunc still
returns NULL for the invalid size, but the guard remains intact.

Validation, rebased and tested on bpf-next master e4287bf34f97
("selftests/bpf: Work around llvm stack overflow in crypto progs"):

  git diff --check origin/master..HEAD: OK
  scripts/checkpatch.pl --strict on 1/2 and 2/2: OK
  make O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next \
    net/netfilter/nf_conntrack_bpf.o: OK
  git am of exported 1/2 and 2/2 on a fresh worktree at base: OK
  range-diff between branch commits and git-am result: equivalent

The local direct clang build of test_bpf_nf.c is blocked by the local
kernel BTF/config: this environment's generated vmlinux.h lacks
struct nf_conn.mark, which is used by pre-existing test_bpf_nf.c code.
The changed kernel object and generated patch application were validated.

Yiyang Chen (2):
  bpf: Guard conntrack opts error writes
  selftests/bpf: Cover small conntrack opts error writes

 net/netfilter/nf_conntrack_bpf.c              | 17 +++++++++---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  6 +++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 26 +++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
-- 
2.34.1


