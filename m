Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3016A3B4
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgBXKQu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Feb 2020 05:16:50 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48600 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbgBXKQt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:16:49 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1j6AnA-0008Lf-OX; Mon, 24 Feb 2020 11:16:48 +0100
Date:   Mon, 24 Feb 2020 11:16:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH libnetfilter_queue] src: add nfq_get_skbinfo()
Message-ID: <20200224101648.GF19559@breakpoint.cc>
References: <20200223234941.44877-1-fw@strlen.de>
 <20200224010344.GA3564@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224010344.GA3564@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> Can I suggest:
> 
>   > + *   example because this is an incoming packet and the NIC does not
>   > + *   perform checksum validation at hardware level.
> - > + * See nfq_set_queue_flags() documentation for more information.
>   > + *
>   > + * \return the skbinfo value
> + > + * \sa __nfq_set_queue_flags__(3)
>   > + */
>   > +EXPORT_SYMBOL
> 
> I think this will look better, especially on the man page.

Its does, thanks.  I've made this change in my local tree.
