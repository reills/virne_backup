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
  id 3
  arrival_time 65.49113411388545
  lifetime 2435.169239839984
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 33
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 24
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 12
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 41
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 17
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
]
