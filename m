Return-Path: <netfilter-devel+bounces-10467-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKPNFOQRemnH2AEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10467-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 14:40:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D9A23F0
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660BB303B7CB
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04D35B130;
	Wed, 28 Jan 2026 13:40:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B4350D67;
	Wed, 28 Jan 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607615; cv=none; b=ZLM5+6gpvvG45MPd/pwQhpiaoMPrHHTmj4whf5KyjDtiOYdsT/yy1vf2yFF9/pO5fOvlEz+XXQINgNfWtpfBxiCsnnqeJNVLZWYvsagfHZFCYm81NQulWX3jGAJoxMJxuWsJN6zm3HQB36yBQ897h/WWrk2d7h8F+qE5PIMSL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607615; c=relaxed/simple;
	bh=cxr2RzuWif9CaT2hCFNa0VeL+SaUHvAQer05FMApM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh/txacwgjBhEuM88rKuxMKWUwR/XA4ZSL73iOC2DEbqoJjgYmuYl7NRbpywEVPorkIvqA4rODMNYWbD6vK9EB5wg8HXKNLCYbzOWD79u+UumlibjWk8KmA1Jqtxa4yiVd26bjbPDvV4t8ev0+jR/GqiZPBTT4DYDPmcczPoobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7288660516; Wed, 28 Jan 2026 14:40:11 +0100 (CET)
Date: Wed, 28 Jan 2026 14:40:12 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+d417922a3e7935517ef6@syzkaller.appspotmail.com>
Cc: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, pablo@netfilter.org, phil@nwl.cc,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in
 nft_array_get_cmp
Message-ID: <aXoRvAottF2YRD3a@strlen.de>
References: <6979fc44.050a0220.c9109.003b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6979fc44.050a0220.c9109.003b.GAE@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=aeae47237b696a30];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10467-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,d417922a3e7935517ef6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: C27D9A23F0
X-Rspamd-Action: no action

syzbot <syzbot+d417922a3e7935517ef6@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    62777c8015f3 Merge branch 'net-stmmac-rk-simplify-per-soc-..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=103e49b2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aeae47237b696a30
> dashboard link: https://syzkaller.appspot.com/bug?extid=d417922a3e7935517ef6
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e50160580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155ce322580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1eb82c60e767/disk-62777c80.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e421b2bad029/vmlinux-62777c80.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3bc19b11eaeb/bzImage-62777c80.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d417922a3e7935517ef6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in nft_set_ext include/net/netfilter/nf_tables.h:795 [inline]
> BUG: KASAN: slab-use-after-free in nft_set_ext_key include/net/netfilter/nf_tables.h:800 [inline]
> BUG: KASAN: slab-use-after-free in nft_array_get_cmp+0x1f6/0x2a0 net/netfilter/nft_set_rbtree.c:133
> Read of size 1 at addr ffff888058618b19 by task syz.3.79/6217
> 
> CPU: 1 UID: 0 PID: 6217 Comm: syz.3.79 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  nft_set_ext include/net/netfilter/nf_tables.h:795 [inline]
>  nft_set_ext_key include/net/netfilter/nf_tables.h:800 [inline]
>  nft_array_get_cmp+0x1f6/0x2a0 net/netfilter/nft_set_rbtree.c:133
>  __inline_bsearch include/linux/bsearch.h:15 [inline]
>  bsearch+0x50/0xc0 lib/bsearch.c:33
>  nft_rbtree_get+0x16b/0x400 net/netfilter/nft_set_rbtree.c:169

Use after free, its possible for rbtree insert to evict elements
due to expiry, but still return -EEXIST.

We can thus end up with removed elements but without a call to
->commit(), hence we have a stale binary blob referencing free'd
elements.

