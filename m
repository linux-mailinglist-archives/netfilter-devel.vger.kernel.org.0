Return-Path: <netfilter-devel+bounces-121-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72A7FDA3F
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE9B20C5B
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483732C93;
	Wed, 29 Nov 2023 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159219A;
	Wed, 29 Nov 2023 06:47:41 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r8Lqi-0006yM-ON; Wed, 29 Nov 2023 15:47:36 +0100
Date: Wed, 29 Nov 2023 15:47:36 +0100
From: Florian Westphal <fw@strlen.de>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
	kadlec@netfilter.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: avoid leakage of skb
Message-ID: <20231129144736.GB24754@breakpoint.cc>
References: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
 <20231129131846.GC27744@breakpoint.cc>
 <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

D. Wythe <alibuda@linux.alibaba.com> wrote:
> And my origin intention was to allow ebpf progs to return NF_STOLEN, we are
> trying to modify some netfilter modules via ebpf,
> and some scenarios require the use of NF_STOLEN, but from your description,

NF_STOLEN can only be supported via a trusted helper, as least as far as
I understand.

Otherwise verifier would have to guarantee that any branch that returns
NF_STOLEN has released the skb, or passed it to a function that will
release the skb in the near future.

