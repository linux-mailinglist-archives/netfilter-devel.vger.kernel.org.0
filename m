Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00183E68
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Aug 2019 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHGAeS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Aug 2019 20:34:18 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:51494 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbfHGAeR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:34:17 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hv9uC-00068G-8j; Wed, 07 Aug 2019 02:34:16 +0200
Date:   Wed, 7 Aug 2019 02:34:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Dirk Morris <dmorris@metaloft.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net] netfilter: Use consistent ct id hash calculation
Message-ID: <20190807003416.v2q3qpwen6cwgzqu@breakpoint.cc>
References: <e5d48c19-508d-e1ed-1f16-8e0a3773c619@metaloft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d48c19-508d-e1ed-1f16-8e0a3773c619@metaloft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dirk Morris <dmorris@metaloft.com> wrote:
> Currently the new ct id is a hash based on several attributes which do
> not change throughout lifetime of the connection. However, the hash
> includes the reply side tuple which does change during NAT on the
> first packet. This means the ct id associated with the first packet of
> a connection pre-NAT is different than it is post-NAT. This means if
> you are using nfqueue or nflog in userspace the associated ct id
> changes from pre-NAT on the first packet to post-NAT on the first
> packet or all subsequent packets.
> 
> Below is a patch that (I think) provides the same level of uniqueness
> of the hash, but is consistent through the lifetime of the first
> packet and afterwards because it only uses the original direction
> tuple.

This is unexpected, as the id function is only supposed to be called
once the conntrack has been confirmed, at which point all NAT side
effects are supposed to be done.

In which case(s) does that assumption not hold?
