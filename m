Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69749233B3D
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jul 2020 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgG3WWi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Jul 2020 18:22:38 -0400
Received: from [216.151.45.106] ([216.151.45.106]:59896 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbgG3WWi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:22:38 -0400
Received: by localhost (Postfix, from userid 1000)
        id B9517D929; Fri, 31 Jul 2020 08:22:36 +1000 (AEST)
Date:   Fri, 31 Jul 2020 08:14:10 +1000
From:   Michael Zhou <mzhou@cse.unsw.edu.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: TEST Re: [PATCH] net/ipv6/netfilter/ip6t_NPT: rewrite addresses in
 ICMPv6 original packet
Message-ID: <20200730141503.3eb212db@dvsy1.host.maki.stream>
In-Reply-To: <20200729204323.GA11285@salvia>
References: <20200720131701.17941-1-mzhou@cse.unsw.edu.au>
 <20200729204323.GA11285@salvia>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thanks for the comments.

On Wed, 29 Jul 2020 22:43:23 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> This ICMPv6 header might fall withing the non-linear data of the
> skbuff.

Might you be able to point me to an example of how to handle and test
this? So far in my testing it has always been in the linear data.

> BTW, does rfc6296 describes what to do with icmp traffic?

Unfortunately not. Do you think this functionality should be an
optional flag or be part of a different target to maintain conformance
with the RFC?
