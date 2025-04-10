graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1650
  arrival_time 36855.79276527679
  lifetime 418.67895941774714
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 0
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 8
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 15
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 33
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 9
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 21
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 12
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 23
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 9
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 37
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 50
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 46
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 36
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 20
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]
