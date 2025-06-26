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
  id 1238
  arrival_time 25543.626069474416
  lifetime 64.88831115670823
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 5
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 32
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 34
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 24
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 5
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 4
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 44
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 38
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 29
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 2
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 2
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 23
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 6
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 16
    gpu 49
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 31
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
]
