Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C13FAF34
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Aug 2021 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhH3ATT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 29 Aug 2021 20:19:19 -0400
Received: from mail.netfilter.org ([217.70.188.207]:38512 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbhH3ATS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:19:18 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 85FAE600B0;
        Mon, 30 Aug 2021 02:17:26 +0200 (CEST)
Date:   Mon, 30 Aug 2021 02:18:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] build: doc: Be sure to rerun doxygen
 after ./configure
Message-ID: <20210830001821.GB17206@salvia>
References: <20210829035051.16916-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210829035051.16916-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 29, 2021 at 01:50:51PM +1000, Duncan Roe wrote:
> doxygen/Makefile was erroneously depending on Makefile.am when it should have
> depended on itself.

Also applied, thanks.
