Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048CE59967
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jun 2019 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfF1LuA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jun 2019 07:50:00 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:54538 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfF1Lt6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:49:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgpO9-0002jS-39; Fri, 28 Jun 2019 13:49:57 +0200
Date:   Fri, 28 Jun 2019 13:49:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Valeri Sytnik <valeri.sytnik@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: if nfqnl_test utility (libnetfilter_queue) drops a packet the
 utility receives the packet again
Message-ID: <20190628114957.jf4n7d53ppp6mieh@breakpoint.cc>
References: <CAF1SjT56zfq9VeUwqwe+vVfB6wija76Ldpa_dhY96x_eo4JU5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1SjT56zfq9VeUwqwe+vVfB6wija76Ldpa_dhY96x_eo4JU5A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Valeri Sytnik <valeri.sytnik@gmail.com> wrote:
> I apply NF_DROP (instead NF_ACCEPT) to some tcp packet which
> contains some specific string known to me (say, hhhhh)
> that packet comes back to the queue again but with different id.

Yes, TCP retransmits data that is not received by the peer.
