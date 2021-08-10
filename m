Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DC3E7CA8
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Aug 2021 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbhHJPof (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Aug 2021 11:44:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42404 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbhHJPoe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:44:34 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id AFF5C60030;
        Tue, 10 Aug 2021 17:43:28 +0200 (CEST)
Date:   Tue, 10 Aug 2021 17:44:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libmnl] build: If doxygen is not available, be sure to
 report "doxygen: no" to ./configure
Message-ID: <20210810154406.GA8978@salvia>
References: <20210807063034.1624-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210807063034.1624-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 07, 2021 at 04:30:34PM +1000, Duncan Roe wrote:
> Also fix bogus "Doxygen not found ..." warning if --without-doxygen given

Applied, thanks for following up.
