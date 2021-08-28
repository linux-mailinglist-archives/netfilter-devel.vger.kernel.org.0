Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C53FA4A4
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhH1JMX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 05:12:23 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49412 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhH1JMV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:12:21 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1D70860226;
        Sat, 28 Aug 2021 11:10:34 +0200 (CEST)
Date:   Sat, 28 Aug 2021 11:11:27 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v3 4/6] build: doc: fix `make
 distcleancheck`
Message-ID: <20210828091127.GD31560@salvia>
References: <20210828033508.15618-1-duncan_roe@optusnet.com.au>
 <20210828033508.15618-4-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210828033508.15618-4-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:35:06PM +1000, Duncan Roe wrote:
> `make distcleancheck` was not passing before this patchset. Now fixed.

Applied, thanks.

5/6 and 6/6 in this series, I'll catch up to review them later.
