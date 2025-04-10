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
  id 947
  arrival_time 20274.60573262207
  lifetime 320.3778343567416
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 26
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 49
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 5
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 36
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 49
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 33
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 9
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 49
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 46
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 7
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
]
