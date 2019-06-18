Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65FA4A32A
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jun 2019 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFROAi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jun 2019 10:00:38 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:52748 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfFROAi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:00:38 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hdEf6-0000ee-IA; Tue, 18 Jun 2019 16:00:36 +0200
Date:   Tue, 18 Jun 2019 16:00:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Mojtaba <mespio@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: working with libnetfilter_queue and linbetfilter_contrack
Message-ID: <20190618140036.ydorhtj5mvjfwemz@breakpoint.cc>
References: <CABVi_Eyws89e+y_4tGJNybGRdL4AarHG6GkNB0d0MGgLABuv3w@mail.gmail.com>
 <20190618095021.doh6pc7gzah3bnra@breakpoint.cc>
 <CABVi_EyyV6jmB8SxuiUKpHzL9NwMLUA1TPk3X=SOq58BFdG9vA@mail.gmail.com>
 <20190618105613.qgfov6jmnov2ba3e@breakpoint.cc>
 <CABVi_ExMpOnaau6sroSXd=Zzc4=F6t0Hv5iCm16q0jxqp5Tjkg@mail.gmail.com>
 <20190618132350.phtpv2vhteplfj32@breakpoint.cc>
 <CABVi_Ey3cHVdnpzRFo_yPFKkPveXeia7WBV4S9iPxPotLkCpuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVi_Ey3cHVdnpzRFo_yPFKkPveXeia7WBV4S9iPxPotLkCpuQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mojtaba <mespio@gmail.com> wrote:
> Then let me describe what i am doing.
> In VoIP networks, One of the ways to solve the one-way audio issue is
> TURN. In this case both endpoint have to send their media (voice as
> RTP) to server. In this conditions the server works as B2BUA. Because
> of the server is processing the media (get media from one hand and
> relay it to another hand), It usages a lot of resource of server. So I
> am implementing  a new module to do this in kernel level. I test this
> idea in my laboratory by adding conntrack entry manually in server and
> all things works great. But i need to get more  idea to do this
> project in best way and high performance, because the QoS very
> importance in VoIP networks. What is the best way? Let me know more
> about this.

In that case I wonder why you need nfqueue at all.

Isn't it enough for the proxy to inject a conntrack entry with the
expected endpoint addresses of the media stream?

I would expect that your proxy consumes/reads the sdp messages from
the client already, or are you doing that via nfqueue?

I would probably use tproxy+normal socket api for the signalling
packets and insert conntrack entries for the rtp/media streams
via libnetfilter_conntrack, this way, the media streams stay in kernel.
