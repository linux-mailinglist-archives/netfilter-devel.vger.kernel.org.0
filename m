Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31CE13087B
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Jan 2020 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEO5Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Jan 2020 09:57:24 -0500
Received: from rain.florz.de ([185.139.32.146]:56931 "EHLO rain.florz.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgAEO5Y (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Jan 2020 09:57:24 -0500
Received: from [2a07:12c0:1c00:43::121] (port=59756 helo=florz.florz.de)
        by rain.florz.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA256:256)
        (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1io7LE-0005XA-Vf
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 15:57:21 +0100
Received: from florz by florz.florz.de with local (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1io7LB-0006vD-Jp
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 15:57:17 +0100
Date:   Sun, 5 Jan 2020 15:57:17 +0100
From:   Florian Zumbiehl <florz@florz.de>
To:     netfilter-devel@vger.kernel.org
Subject: [nftables] bug: rejects empty set literals
Message-ID: <20200105145717.GG3854@florz.florz.de>
Mail-Followup-To: netfilter-devel@vger.kernel.org, florz@florz.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I guess I found another bug:

| # nft 'table ip t { chain c { ip saddr { }; }; }'
| Error: syntax error, unexpected '}'
| table ip t { chain c { ip saddr { }; }; }
|                                   ^

Now, this does match what the documentation says (you have to have at least
one item in a set literal), but I would think that that also should count
as a bug, as (a) it isn't exactly useful to have arbitrary exceptions on
what (set) values can be specified and (b) nftables handles empty sets just
fine, it's just the input syntax that is complicated.

Regards, Florian
