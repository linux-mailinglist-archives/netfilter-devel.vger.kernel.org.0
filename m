Return-Path: <netfilter-devel+bounces-5322-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FE9D8BE3
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Nov 2024 19:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E22B31284
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Nov 2024 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91E1BD038;
	Mon, 25 Nov 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Vz/y+APZ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F91BC9EE
	for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557597; cv=none; b=eGVacKJrGty82n6Wk6+9kr8a2O4gJOnOlWoq2YpAGPsPmNw4OW0BIVwGp43gnr7GnvKDsTUrUYTYSCY2zX3qvvvsTRu8X29e+6ag0yIpOGDmWzxtxz3zhnIiY4I7q+sE7hf8D1Nrm8hgNSDBehn0R/IR8Ff86Q84r83uXxwOblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557597; c=relaxed/simple;
	bh=V5N4wSUZrBPuCZ/XKy+HU1S/9iyK0UN1290lQKfMNms=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F3sQMqekQTwAlla21t4X6hOCBL3vuCSbO5il3ia/4l4Cvt3J4FiBMcdHU859mJYIIBW+6MkBHrcopxRsDMi38190Ct1CWcxoFG5luIZi1mNyuDarRhJOp4Fjxtn7gVfaoZgY5DDfNjq5ZxmL2iGve8Xjeofcy60nlbDgdQXnXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Vz/y+APZ; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 9FD5B80CD9
	for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2024 19:59:47 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS
	for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2024 19:59:46 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 37359303248;
	Mon, 25 Nov 2024 19:59:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1732557574; bh=V5N4wSUZrBPuCZ/XKy+HU1S/9iyK0UN1290lQKfMNms=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Vz/y+APZW/fp7aSEDdYfl2HL12Ly4g47GuG9/uZ/SjF4n62iUW75Tjpzj8PC0DwwR
	 KcjpelfK5wYlaKZaIbK2BecBEjiMSKOgG00anIJR5J3r+prqsxqiDA1iasgVg+kfJw
	 aBCV8gKnx5cEDFNNupYNs/xwB5yEWAPT3ilabObE=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.17.1) with ESMTP id 4APHxJKD053777;
	Mon, 25 Nov 2024 19:59:21 +0200
Date: Mon, 25 Nov 2024 19:59:19 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Jinghao Jia <jinghao7@illinois.edu>
cc: Simon Horman <horms@verge.net.au>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>, Ruowen Qin <ruqin@redhat.com>
Subject: Re: [PATCH v3 net] ipvs: fix UB due to uninitialized stack access
 in ip_vs_protocol_init()
In-Reply-To: <20241123094256.28887-1-jinghao7@illinois.edu>
Message-ID: <8b210ce9-19d8-eefd-fc86-febdc33394f6@ssi.bg>
References: <20241123094256.28887-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Sat, 23 Nov 2024, Jinghao Jia wrote:

> Under certain kernel configurations when building with Clang/LLVM, the
> compiler does not generate a return or jump as the terminator
> instruction for ip_vs_protocol_init(), triggering the following objtool
> warning during build time:
> 
>   vmlinux.o: warning: objtool: ip_vs_protocol_init() falls through to next function __initstub__kmod_ip_vs_rr__935_123_ip_vs_rr_init6()
> 
> At runtime, this either causes an oops when trying to load the ipvs
> module or a boot-time panic if ipvs is built-in. This same issue has
> been reported by the Intel kernel test robot previously.
> 
> Digging deeper into both LLVM and the kernel code reveals this to be a
> undefined behavior problem. ip_vs_protocol_init() uses a on-stack buffer
> of 64 chars to store the registered protocol names and leaves it
> uninitialized after definition. The function calls strnlen() when
> concatenating protocol names into the buffer. With CONFIG_FORTIFY_SOURCE
> strnlen() performs an extra step to check whether the last byte of the
> input char buffer is a null character (commit 3009f891bb9f ("fortify:
> Allow strlen() and strnlen() to pass compile-time known lengths")).
> This, together with possibly other configurations, cause the following
> IR to be generated:
> 
>   define hidden i32 @ip_vs_protocol_init() local_unnamed_addr #5 section ".init.text" align 16 !kcfi_type !29 {
>     %1 = alloca [64 x i8], align 16
>     ...
> 
>   14:                                               ; preds = %11
>     %15 = getelementptr inbounds i8, ptr %1, i64 63
>     %16 = load i8, ptr %15, align 1
>     %17 = tail call i1 @llvm.is.constant.i8(i8 %16)
>     %18 = icmp eq i8 %16, 0
>     %19 = select i1 %17, i1 %18, i1 false
>     br i1 %19, label %20, label %23
> 
>   20:                                               ; preds = %14
>     %21 = call i64 @strlen(ptr noundef nonnull dereferenceable(1) %1) #23
>     ...
> 
>   23:                                               ; preds = %14, %11, %20
>     %24 = call i64 @strnlen(ptr noundef nonnull dereferenceable(1) %1, i64 noundef 64) #24
>     ...
>   }
> 
> The above code calculates the address of the last char in the buffer
> (value %15) and then loads from it (value %16). Because the buffer is
> never initialized, the LLVM GVN pass marks value %16 as undefined:
> 
>   %13 = getelementptr inbounds i8, ptr %1, i64 63
>   br i1 undef, label %14, label %17
> 
> This gives later passes (SCCP, in particular) more DCE opportunities by
> propagating the undef value further, and eventually removes everything
> after the load on the uninitialized stack location:
> 
>   define hidden i32 @ip_vs_protocol_init() local_unnamed_addr #0 section ".init.text" align 16 !kcfi_type !11 {
>     %1 = alloca [64 x i8], align 16
>     ...
> 
>   12:                                               ; preds = %11
>     %13 = getelementptr inbounds i8, ptr %1, i64 63
>     unreachable
>   }
> 
> In this way, the generated native code will just fall through to the
> next function, as LLVM does not generate any code for the unreachable IR
> instruction and leaves the function without a terminator.
> 
> Zero the on-stack buffer to avoid this possible UB.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402100205.PWXIz1ZK-lkp@intel.com/
> Co-developed-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
> Changelog:
> v2 -> v3:
> v2: https://lore.kernel.org/lkml/20241122045257.27452-1-jinghao7@illinois.edu/
> * Fix changelog format based on Julian's feedback
> 
> v1 -> v2:
> v1: https://lore.kernel.org/lkml/20241111065105.82431-1-jinghao7@illinois.edu/
> * Fix small error in commit message
> * Address Julian's feedback:
>   * Make this patch target the net tree rather than net-next
>   * Add a "Fixes" tag for the initial git commit
> 
>  net/netfilter/ipvs/ip_vs_proto.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_proto.c b/net/netfilter/ipvs/ip_vs_proto.c
> index f100da4ba3bc..a9fd1d3fc2cb 100644
> --- a/net/netfilter/ipvs/ip_vs_proto.c
> +++ b/net/netfilter/ipvs/ip_vs_proto.c
> @@ -340,7 +340,7 @@ void __net_exit ip_vs_protocol_net_cleanup(struct netns_ipvs *ipvs)
>  
>  int __init ip_vs_protocol_init(void)
>  {
> -	char protocols[64];
> +	char protocols[64] = { 0 };
>  #define REGISTER_PROTOCOL(p)			\
>  	do {					\
>  		register_ip_vs_protocol(p);	\
> @@ -348,8 +348,6 @@ int __init ip_vs_protocol_init(void)
>  		strcat(protocols, (p)->name);	\
>  	} while (0)
>  
> -	protocols[0] = '\0';
> -	protocols[2] = '\0';
>  #ifdef CONFIG_IP_VS_PROTO_TCP
>  	REGISTER_PROTOCOL(&ip_vs_protocol_tcp);
>  #endif
> -- 
> 2.47.0

Regards

--
Julian Anastasov <ja@ssi.bg>


