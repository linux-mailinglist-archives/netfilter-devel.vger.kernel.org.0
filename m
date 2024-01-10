Return-Path: <netfilter-devel+bounces-530-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968D821C8B
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 14:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1EB1F21C8B
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09876FBEB;
	Tue,  2 Jan 2024 13:28:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A35FBE4;
	Tue,  2 Jan 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=56470 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rKeot-007xke-Pr; Tue, 02 Jan 2024 14:28:37 +0100
Date: Tue, 2 Jan 2024 14:28:35 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 01/14] netfilter: cleanup enum nft_set_class
Message-ID: <ZZQPgodwl/xp5ePw@calendula>
References: <20231226094255.77911-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226094255.77911-1-dongtai.guo@linux.dev>
X-Spam-Score: -1.9 (-)

On Tue, Dec 26, 2023 at 05:42:42PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Correct comments for nlpid, family, udlen and udata in struct nft_table,
> and afinfo is no longer a member of enum nft_set_class.

Thanks for your series.

My plan is to squash this series in one single patch and then apply to
the netfilter tree.

