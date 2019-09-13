Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC63B237B
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfIMPfx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 11:35:53 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55940 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbfIMPfx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:35:53 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i8nbx-0003Ry-2c; Fri, 13 Sep 2019 17:35:49 +0200
Date:   Fri, 13 Sep 2019 17:35:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] parser_bison: Fix 'exists' keyword on Big Endian
Message-ID: <20190913153549.GB10656@breakpoint.cc>
References: <20190913153224.486-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913153224.486-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> -					   BYTEORDER_HOST_ENDIAN, 1, buf);
> +					   BYTEORDER_HOST_ENDIAN,
> +					   sizeof(char) * BITS_PER_BYTE, buf);

You can omit the sizeof(char), its always 1.  Otherwise this loooks good to me.
