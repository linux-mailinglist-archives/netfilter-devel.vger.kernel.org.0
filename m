Return-Path: <netfilter-devel+bounces-376-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE07814A45
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Dec 2023 15:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5499E1F26908
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Dec 2023 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED02FE3E;
	Fri, 15 Dec 2023 14:17:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88730CE1;
	Fri, 15 Dec 2023 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rE904-0005oD-7W; Fri, 15 Dec 2023 15:17:12 +0100
Date: Fri, 15 Dec 2023 15:17:12 +0100
From: Florian Westphal <fw@strlen.de>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org
Subject: Re: [RFC nf-next v1 1/2] netfilter: bpf: support prog update
Message-ID: <20231215141712.GA17065@breakpoint.cc>
References: <1702609653-45835-1-git-send-email-alibuda@linux.alibaba.com>
 <1702609653-45835-2-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702609653-45835-2-git-send-email-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

D. Wythe <alibuda@linux.alibaba.com> wrote:
>  	const struct nf_defrag_hook *defrag_hook;
> +	const struct bpf_prog __rcu *nf_prog;

Hmm, why do we need this pointer?
Can't you just re-use bpf_nf_link->link.prog?

> +	rcu_assign_pointer(nf_link->nf_prog, new_prog);
> +	old_prog = xchg(&link->prog, new_prog);

This looks redundant, I think you can remove the nf_prog
pointer again.

Rest LGTM.

