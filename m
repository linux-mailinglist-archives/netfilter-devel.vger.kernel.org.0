Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2229F50
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 21:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfEXTqK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 15:46:10 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:56810 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732118AbfEXTqK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 15:46:10 -0400
Received: from [31.4.219.201] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hUG8l-0004FI-13; Fri, 24 May 2019 21:46:09 +0200
Date:   Fri, 24 May 2019 21:46:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v4] tests: py: fix python3
Message-ID: <20190524194605.y4gtny534yffs4hj@salvia>
References: <20190523182622.386876-1-shekhar250198@gmail.com>
 <20190524193600.mx434k2r6if4dzqd@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524193600.mx434k2r6if4dzqd@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 24, 2019 at 09:36:00PM +0200, Pablo Neira Ayuso wrote:
> On Thu, May 23, 2019 at 11:56:22PM +0530, Shekhar Sharma wrote:
> > This version of the patch converts the file into python3 and also uses
> > .format() method to make the print statments cleaner.
> 
> Applied, thanks.

Hm.

I'm hitting this here after applying this:

# python nft-test.py
Traceback (most recent call last):
  File "nft-test.py", line 17, in <module>
    from nftables import Nftables
ImportError: No module named nftables
