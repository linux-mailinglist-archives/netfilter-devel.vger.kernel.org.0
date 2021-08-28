Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26A83FA4A3
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhH1JLp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 05:11:45 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49398 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhH1JLo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:11:44 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 791FD60226;
        Sat, 28 Aug 2021 11:09:57 +0200 (CEST)
Date:   Sat, 28 Aug 2021 11:10:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v3 3/6] build: doc: Avoid having to
 special-case `make distcheck`
Message-ID: <20210828091050.GC31560@salvia>
References: <20210828033508.15618-1-duncan_roe@optusnet.com.au>
 <20210828033508.15618-3-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210828033508.15618-3-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:35:05PM +1000, Duncan Roe wrote:
> - Move doxygen.cfg.in to doxygen/
> - Tell doxygen.cfg.in where the sources are
> - Let doxygen.cfg.in default its output to CWD
> - In Makefile, `doxygen doxygen.cfg` "just works"

Applied, thanks.
