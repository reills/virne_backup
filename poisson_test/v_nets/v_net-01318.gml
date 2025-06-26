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
  id 1318
  arrival_time 27622.9217217634
  lifetime 529.5593242634933
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 47
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 10
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 10
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 19
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 10
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 3
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 37
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
