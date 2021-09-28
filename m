Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7841ACD6
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Sep 2021 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhI1KXS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Sep 2021 06:23:18 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57118 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1KXS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:23:18 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2539C63595;
        Tue, 28 Sep 2021 12:20:15 +0200 (CEST)
Date:   Tue, 28 Sep 2021 12:21:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v4 0/1] build: doc: Allow to specify
 whether to produce man pages, html, neither or both
Message-ID: <YVLsrpzVRF/tztcU@salvia>
References: <20210924053242.7846-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210924053242.7846-1-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:32:41PM +1000, Duncan Roe wrote:
> Hi Pablo,
> 
> This version simplifies the configure.ac patch by removing --with-doxygen
> altogether.
> ./configure will not even look for doxygen if no documentation is requested,

Applied to libnetfilter_log as you clarified, thanks.
