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
  id 1796
  arrival_time 39871.82559487768
  lifetime 2131.2788367851763
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 33
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 50
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 27
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 41
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 12
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 6
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 23
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 11
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 31
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 23
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 14
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 31
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
]
