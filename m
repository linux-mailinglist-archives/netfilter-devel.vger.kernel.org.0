Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2785B83341
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Aug 2019 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHFNso (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Aug 2019 09:48:44 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48698 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbfHFNso (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:48:44 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1huzpP-0002Uo-Ri; Tue, 06 Aug 2019 15:48:39 +0200
Date:   Tue, 6 Aug 2019 15:48:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC nf-next] Introducing stateful object update operation
Message-ID: <20190806134839.6o2dpp5e375pnkrf@breakpoint.cc>
References: <20190806102945.728-1-ffmancera@riseup.net>
 <20190806110648.khukqwbmxgbk5yfr@salvia>
 <146bb849-c4cf-1c88-cacf-fa909a626cac@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146bb849-c4cf-1c88-cacf-fa909a626cac@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> > Use the existing nf_tables_newobj(), if NLM_F_EXCL is not set on and
> > the object exists, then this is an update.
> 
> I agree on that. But I think that if we use the NFT_MSG_NEWOBJ there
> will be some issues in the commit and the abort phase. That is why I
> think "NFT_MSG_UPDOBJ" would be needed.

See e.g. 'nft_trans_table_update()' -- we already do this for
other structures/entities.  You would need to extend the object handling
to not remove an already-existed-object in case of an update if an abort
is triggered.
