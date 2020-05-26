Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8832A1AE5EB
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2020 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgDQTjG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Apr 2020 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgDQTjG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:39:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8DC061A0C
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2020 12:39:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so2059401edv.8
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2020 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
        b=e9qXFUILLsybOfJKcCcKe1kagTFK2kJtVvv8ARMXKYswAVrOFnvVrea/d+vgn11rg6
         Z/M34SKvyevBhrOTwLx3Kf/FWWLy9BJ043Nu086rcu5gYJ4IZhKjB+2LzYXPsTyblICW
         8knYFNijCRO9t3vxbv3HWkRclL9Ipx0e5ON8G8Jt4hqjTpjsTAHRlIi/z5veGPaoPH6/
         wW+To+2r10hFY4GxE0xPN0+PIzAKoj+1/JAezAkCq5P3rcKqPXL5BspSbG1ANGN76bnJ
         tQ30z7BCUVc105Gq53GEWLASJ6w+90PQ2dVzSWCBu/BaKniuoHEFF3WTEz/jo1bpTZVW
         x8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
        b=bR+ucQ1vDAVdVnxHVe6KDrsbgmLlwJAzJ+GUx8gPfaBGcujYwRpeB816+LdLmJP5fz
         2HqF3hTWDOX2/b9GMxMr5SZ7cZaURNgMJ1sGcLA1jpwo+pSSulU3jZbRnUo4qrUdV6F5
         KnG3SojQP22QRlZVqD/TKpjekCW7TYGg6U30s4koRvxFrcCXYTVyX/dsI7Ye9r++BYoo
         QgeX3j20G14vQ3qFhyZvjHbbPYp+tUzuhGS93+qNjqUn7jPbXF6ACQmYvyTDDmANjjNI
         WHLSLN3zj7m+1UH/lQeLfWSw2aUGyd2XaIk9BpyGKvPCqPPfjdL19jA2ysbFHyzdZVyB
         KVuw==
X-Gm-Message-State: AGi0PuY1SaHJgbZTIeqbQeheBgKuL8Kt417801qiOmE7PWZQsAf6hcdC
        3O8WKvoRMK4bfu8+lcBWLWScIaLmbLhO1GOzXlSrwA==
X-Google-Smtp-Source: APiQypIMmcwslCwM0okBNvcYxbM9gV9GiUWRIS9McGHSYGELVOuJppY9MYNVGFdRJQhvIAGhrdprOx1DaNQUNTrnfDc=
X-Received: by 2002:a50:ee86:: with SMTP id f6mr4905364edr.123.1587152344379;
 Fri, 17 Apr 2020 12:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200407202337.63505-1-mattst88@gmail.com>
In-Reply-To: <20200407202337.63505-1-mattst88@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 17 Apr 2020 12:38:53 -0700
Message-ID: <CAEdQ38HGYSvR9yg+Zx6Jm50dL-WVkEJwtB-K=A3zL7tpH1ymyA@mail.gmail.com>
Subject: Re: [PATCH nftables] build: Allow building from tarballs without yacc/lex
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ping
