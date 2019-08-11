Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD46891BB
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Aug 2019 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHKNAn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Aug 2019 09:00:43 -0400
Received: from clark.ferree-clark.org ([74.95.126.33]:50305 "EHLO
        clark.ferree-clark.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfHKNAm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Aug 2019 09:00:42 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 09:00:42 EDT
Received: from tcthink.ferree-clark.org (thinkpadw550s-wireless.ferree-clark.org [10.1.10.10])
        (authenticated bits=0)
        by clark.ferree-clark.org (8.15.2/8.15.2) with ESMTPSA id x7BCqGMa020097
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <netfilter-devel@vger.kernel.org>; Sun, 11 Aug 2019 05:52:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 clark.ferree-clark.org x7BCqGMa020097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clark.bz;
        s=clark2016; t=1565527936;
        bh=5YQ+nvwNh//utTPw7x/d1IjUXWvywVXs2HdNsiSoG28=;
        h=To:From:Subject:Date:From;
        b=if4A0U9NMa9FWWUFBc63pjWgdJorq6gE4gFr3Jl9enG0hKTWdlOzc6Y1QohWeEdPR
         Yjb/E7JahM33gxuDIgvOFNO6Ipfd181xCkjc1n87OCBCX0I0qnV4+8chBBulr28ITU
         IbseAsy9giJoKrT8QZqlxTnCjw2HgDvIQMexBNAc=
To:     netfilter-devel@vger.kernel.org
From:   "Thomas B. Clark" <kernel@clark.bz>
Subject: geoip doesn't work with ipv6
Message-ID: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org>
Date:   Sun, 11 Aug 2019 05:52:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.1.10.2
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I have tried exhaustively to get xt_geoip to match ipv6 addresses, and 
it doesn't.

I believe my configuration is correct, and that the geoip databases are 
set up correctly.  Matching correctly works on ipv4 with an equivalent 
iptables.


