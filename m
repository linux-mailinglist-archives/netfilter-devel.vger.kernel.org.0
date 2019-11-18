Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7943A1007B5
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Nov 2019 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKROz1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 09:55:27 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34098 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKROz1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:55:27 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iWiR4-0006nY-7F; Mon, 18 Nov 2019 15:55:26 +0100
Date:   Mon, 18 Nov 2019 15:55:26 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: set reference from variable definition
Message-ID: <20191118145526.GH17739@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191118144050.116043-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118144050.116043-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 18, 2019 at 03:40:50PM +0100, Pablo Neira Ayuso wrote:
> Allow to define variable using set reference, eg.
> 
> 	define x = @z
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>
