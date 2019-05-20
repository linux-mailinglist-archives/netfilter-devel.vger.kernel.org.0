Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6024176
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfETTsg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:48:36 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:60366 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfETTsf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:48:35 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSoGv-0003o9-4F; Mon, 20 May 2019 21:48:33 +0200
Date:   Mon, 20 May 2019 21:48:33 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 2/4] netfilter: synproxy: remove module
 dependency on IPv6 SYNPROXY
Message-ID: <20190520194833.g6zoy2zvqjmovv3u@breakpoint.cc>
References: <20190519205259.2821-1-ffmancera@riseup.net>
 <20190519205259.2821-3-ffmancera@riseup.net>
 <20190519211207.mi3mbgtjcsbijsve@breakpoint.cc>
 <0d96ae82-74b8-4c30-d684-1221d8b4fe44@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d96ae82-74b8-4c30-d684-1221d8b4fe44@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> > ERROR: "ipv4_synproxy_hook" [net/ipv6/netfilter/ip6t_SYNPROXY.ko] undefined!
> >    ERROR: "synproxy_send_client_synack_ipv6" [net/ipv6/netfilter/ip6t_SYNPROXY.ko] undefined!
> >    ERROR: "synproxy_recv_client_ack_ipv6" [net/ipv6/netfilter/ip6t_SYNPROXY.ko] undefined!
> >    ERROR: "nf_synproxy_ipv6_init" [net/ipv6/netfilter/ip6t_SYNPROXY.ko] undefined!
> >    ERROR: "nf_synproxy_ipv6_fini" [net/ipv6/netfilter/ip6t_SYNPROXY.ko] undefined!
> >    ERROR: "ipv4_synproxy_hook" [net/ipv4/netfilter/ipt_SYNPROXY.ko] undefined!
> >    ERROR: "synproxy_send_client_synack" [net/ipv4/netfilter/ipt_SYNPROXY.ko] undefined!
> >    ERROR: "synproxy_recv_client_ack" [net/ipv4/netfilter/ipt_SYNPROXY.ko] undefined!
> >    ERROR: "nf_synproxy_ipv4_init" [net/ipv4/netfilter/ipt_SYNPROXY.ko] undefined!
> >    ERROR: "nf_synproxy_ipv4_fini" [net/ipv4/netfilter/ipt_SYNPROXY.ko] undefined!
> 
> Why undefined? I have exported them with EXPORT_SYMBOL_GPL(). What am I
> missing? Thanks!

The only cases I can think of are these:

a) synproxy_send_client_synack_ipv6 etc. is not exported
b) synproxy_send_client_synack_ipv6 are exported, but not built
   (usually points to a dependency bug).
c) synproxy_send_client_synack_ipv6 are in a module, but foo.o is builtin

Above errors would hint at b). You can check the .config if thats the
case or not.
