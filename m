Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE23D00CF
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJHSrM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 14:47:12 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48792 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfJHSrM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:12 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iHuVr-0006QC-7o; Tue, 08 Oct 2019 20:47:11 +0200
Date:   Tue, 8 Oct 2019 20:47:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: fix failed tests due to missing quotes
Message-ID: <20191008184711.GI12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Eric Jallot <ejallot@gmail.com>, netfilter-devel@vger.kernel.org
References: <20191008180632.28583-1-ejallot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008180632.28583-1-ejallot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:06:32PM +0200, Eric Jallot wrote:
> Add double quotes to protect newlines when using <<< redirection.
> 
> See also commit b878cb7d83855.
> 
> Signed-off-by: Eric Jallot <ejallot@gmail.com>

Applied, thanks!
