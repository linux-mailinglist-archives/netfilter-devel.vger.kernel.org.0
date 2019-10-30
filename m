Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E0E93F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 01:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfJ3AA4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Oct 2019 20:00:56 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:32926 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfJ3AA4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:00:56 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iPbPw-0000tg-TL; Wed, 30 Oct 2019 01:00:53 +0100
Date:   Wed, 30 Oct 2019 01:00:52 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue] src: doc: Document
 nfq_nlmsg_verdict_put_mark() and nfq_nlmsg_verdict_put_pkt()
Message-ID: <20191030000052.GC876@breakpoint.cc>
References: <20191027083804.24152-1-duncan_roe@optusnet.com.au>
 <20191029235420.GB3149@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029235420.GB3149@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> Anything wrong with this? It's the first of many libnetfilter_queue
> documentation updates I was planning to send.

Can't see anything wrong, so I applied this, thanks Duncan.
