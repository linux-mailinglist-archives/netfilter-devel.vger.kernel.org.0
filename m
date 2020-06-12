Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56EF1F7BB1
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2020 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLQfB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Jun 2020 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLQfB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:35:01 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D78C03E96F
        for <netfilter-devel@vger.kernel.org>; Fri, 12 Jun 2020 09:35:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jjmdt-0006Kp-VC; Fri, 12 Jun 2020 18:34:58 +0200
Date:   Fri, 12 Jun 2020 18:34:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: Extensions for ICMP[6] with sport, dport
Message-ID: <20200612163457.GB16460@breakpoint.cc>
References: <5EDE75D5.7020303@openfortress.nl>
 <20200609094159.GA21317@breakpoint.cc>
 <5EDF687A.6020801@openfortress.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EDF687A.6020801@openfortress.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rick van Rein <rick@openfortress.nl> wrote:
>  - Encapsulated traffic travels in reverse compared to a tunnel
>  - ICMP-contained content must be NAT-reversed, unlike tunnel content

nf_nat takes care of this automatically.

> 
> I would argue that these provide (not 100% hard) reasons to treat ICMP differently from tunnels.  Possibly syntaxes, in line with what "nft" does now, could say things like
> 
> ip protocol icmp
> icmp protocol { tcp, udp, sctp, dccp }

What would that do?  "ip protocol" of embedded ip header?

> icmp th daddr set
>    icmp th dport map @my-nat-map

th daddr looks weird to me, but syntax could
be changed later.

Dependency generation and delineraization would
likely be more of a challenge.

> If this ends up being kernel work, then I'm afraid I will have to let go.

It can probably be done using fixed offsets for this
specific case but its likely a lot of work wrt. dependency
checking and providing readable syntax for "nft list" again.
