Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BD1F372A
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2020 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFIJmE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Jun 2020 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgFIJmE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:42:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667AC05BD1E
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2020 02:42:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jialb-0005bH-C6; Tue, 09 Jun 2020 11:41:59 +0200
Date:   Tue, 9 Jun 2020 11:41:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Extensions for ICMP[6] with sport, dport
Message-ID: <20200609094159.GA21317@breakpoint.cc>
References: <5EDE75D5.7020303@openfortress.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EDE75D5.7020303@openfortress.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rick van Rein <rick@openfortress.nl> wrote:

[ dropped patrick from cc ]

> A sketch of code is below; I am unsure about the [THDR_?PORT] but I
> think the "sport" and "dport" should be interpreted in reverse for ICMP,
> as it travels upstream.  That would match "l4proto sport" match ICMP
> along with the TCP, UDP, SCTP and DCCP to which it relates.  It also
> seems fair that ICMP with a "dport" targets the port at the ICMP target,
> so the originator of the initial message.
> 
> 
> If you want me to continue on this, I need to find a way into
> git.kernel.org and how to offer code.  Just point me to howto's.  I also
> could write a Wiki about Stateful Filter WHENTO-and-HOWTO.

I think instead of this specific use case it would be preferrable to
tackle this in a more general way, via more generic "ip - in foo"
matching.

See
https://people.netfilter.org/2019/wiki/index.php/General_Agenda#match_packets_inside_tunnels

for a summary of inner header matching.

I suspect that for this case we would want something like

filter forward inner ip in icmp tcp dport 42

It would require lots of kernel changes, for example a new displaycement
register and changes to existing payload expression to use it, so it
would access the embedded tcp header.
