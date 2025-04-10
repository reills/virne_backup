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
  id 1878
  arrival_time 41427.73076425714
  lifetime 239.40702966086866
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 18
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 28
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 42
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 41
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 1
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 4
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 10
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
]
